const express = require('express');
const cors = require('cors');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Data file paths
const quotesFile = path.join(__dirname, 'data', 'quotes.json');
const trackingFile = path.join(__dirname, 'data', 'tracking.json');
const messagesFile = path.join(__dirname, 'data', 'messages.json');

// Helper functions for JSON storage
function readData(filePath, fallback = []) {
  try {
    if (!fs.existsSync(filePath)) {
      fs.writeFileSync(filePath, JSON.stringify(fallback, null, 2));
      return fallback;
    }
    const content = fs.readFileSync(filePath, 'utf8');
    return JSON.parse(content || '[]');
  } catch (err) {
    console.error(`Error reading ${filePath}:`, err);
    return fallback;
  }
}

function writeData(filePath, data) {
  try {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), 'utf8');
    return true;
  } catch (err) {
    console.error(`Error writing ${filePath}:`, err);
    return false;
  }
}

// Distance & Rate calculation matrix (from Kattedan, Hyderabad hub)
const distanceMatrix = {
  mumbai: { km: 710, hours: "16-18 hrs", baseRatePerTon: 2900 },
  bengaluru: { km: 570, hours: "12-14 hrs", baseRatePerTon: 2400 },
  chennai: { km: 630, hours: "14-16 hrs", baseRatePerTon: 2600 },
  delhi: { km: 1580, hours: "36-40 hrs", baseRatePerTon: 4800 },
  kolkata: { km: 1490, hours: "34-38 hrs", baseRatePerTon: 4600 },
  pune: { km: 560, hours: "12-14 hrs", baseRatePerTon: 2300 },
  ahmedabad: { km: 1190, hours: "26-30 hrs", baseRatePerTon: 3900 },
  nagpur: { km: 500, hours: "10-12 hrs", baseRatePerTon: 2100 },
  vijayawada: { km: 275, hours: "6-7 hrs", baseRatePerTon: 1400 },
  visakhapatnam: { km: 620, hours: "13-15 hrs", baseRatePerTon: 2550 },
  coimbatore: { km: 920, hours: "20-22 hrs", baseRatePerTon: 3400 },
  hyderabad: { km: 40, hours: "Same Day / 4 hrs", baseRatePerTon: 800 }
};

// API: Instant Rate Estimate
app.post('/api/estimate-rate', (req, res) => {
  const { pickupCity = 'hyderabad', dropCity = 'mumbai', weightTons = 5, vehicleType = 'standard' } = req.body;
  
  const destKey = dropCity.toLowerCase().trim();
  const info = distanceMatrix[destKey] || { km: 750, hours: "18-24 hrs", baseRatePerTon: 3000 };
  
  const tons = Math.max(1, parseFloat(weightTons) || 1);
  let vehicleMultiplier = 1.0;
  if (vehicleType.includes('32ft')) vehicleMultiplier = 1.25;
  else if (vehicleType.includes('Trailer')) vehicleMultiplier = 1.45;
  else if (vehicleType.includes('20ft')) vehicleMultiplier = 1.1;

  const estimatedBase = Math.round(info.km * 38 + tons * info.baseRatePerTon * 0.45 * vehicleMultiplier);
  const minPrice = Math.round(estimatedBase * 0.95);
  const maxPrice = Math.round(estimatedBase * 1.12);

  res.json({
    success: true,
    pickup: pickupCity,
    destination: dropCity,
    distanceKm: info.km,
    transitTime: info.hours,
    estimatedPriceRange: `₹${minPrice.toLocaleString('en-IN')} - ₹${maxPrice.toLocaleString('en-IN')}`,
    tollAndFuelIncluded: true,
    gpsTrackingIncluded: true
  });
});

// API: Quotes (Enquiries)
app.get('/api/quotes', (req, res) => {
  const quotes = readData(quotesFile, []);
  res.json(quotes);
});

app.post('/api/quotes', (req, res) => {
  const quotes = readData(quotesFile, []);
  const {
    name,
    phone,
    email,
    company = '',
    pickupCity,
    pickupPincode = '',
    dropCity,
    dropPincode = '',
    cargoType = 'General Cargo',
    weightTons = 1,
    vehicleType = 'Container Truck',
    pickupDate = '',
    notes = ''
  } = req.body;

  if (!name || !phone || !pickupCity || !dropCity) {
    return res.status(400).json({ error: 'Please provide Name, Phone, Pickup City, and Drop City.' });
  }

  // Calculate estimated price
  const destKey = (dropCity || '').toLowerCase().trim();
  const info = distanceMatrix[destKey] || { km: 700, hours: "18-22 hrs", baseRatePerTon: 2800 };
  const tons = Math.max(1, parseFloat(weightTons) || 1);
  const estBase = Math.round(info.km * 38 + tons * info.baseRatePerTon * 0.45);
  const estPrice = `₹${Math.round(estBase * 0.95).toLocaleString('en-IN')} - ₹${Math.round(estBase * 1.12).toLocaleString('en-IN')}`;

  const newQuote = {
    id: `SCC-Q-${Math.floor(1000 + Math.random() * 9000)}`,
    createdAt: new Date().toISOString(),
    name,
    phone,
    email,
    company,
    pickupCity,
    pickupPincode,
    dropCity,
    dropPincode,
    cargoType,
    weightTons: parseFloat(weightTons) || 1,
    vehicleType,
    pickupDate,
    estimatedPrice: estPrice,
    status: 'New',
    notes
  };

  quotes.unshift(newQuote);
  writeData(quotesFile, quotes);

  // Pre-create tracking draft
  const trackingData = readData(trackingFile, []);
  const newTracking = {
    trackingId: newQuote.id,
    customer: company || name,
    origin: `${pickupCity} (Kattedan Hub)`,
    destination: `${dropCity} Delivery Terminal`,
    status: 'Quote Approved / Dispatch Pending',
    progressPercent: 15,
    currentLocation: `${pickupCity} Freight Depot`,
    truckNumber: 'Vehicle Allocation in Progress',
    driverName: 'Assigned on Dispatch',
    driverPhone: '+91 88674 44552',
    dispatchDate: pickupDate || 'Scheduled Soon',
    expectedDelivery: 'Within Estimated Transit Window',
    cargoType,
    checkpoints: [
      { location: `${pickupCity} Pickup Depot`, time: 'Initiated', status: 'Enquiry Received & Verified', done: true },
      { location: `Kattedan Hub Loading Bay`, time: 'Upcoming', status: 'Loading & Transit Manifest', done: false },
      { location: `National Highway Route to ${dropCity}`, time: 'Upcoming', status: 'GPS Fleet Transit', done: false },
      { location: `${dropCity} Final Consignee Destination`, time: 'Upcoming', status: 'Delivery & POD Collection', done: false }
    ]
  };
  trackingData.unshift(newTracking);
  writeData(trackingFile, trackingData);

  res.status(201).json({
    success: true,
    message: 'Transportation quote request submitted successfully!',
    quote: newQuote
  });
});

app.patch('/api/quotes/:id', (req, res) => {
  const { id } = req.params;
  const { status, notes } = req.body;
  const quotes = readData(quotesFile, []);
  const index = quotes.findIndex(q => q.id === id);

  if (index === -1) {
    return res.status(404).json({ error: 'Quote not found' });
  }

  if (status) quotes[index].status = status;
  if (notes !== undefined) quotes[index].notes = notes;

  writeData(quotesFile, quotes);
  res.json({ success: true, quote: quotes[index] });
});

app.delete('/api/quotes/:id', (req, res) => {
  const { id } = req.params;
  let quotes = readData(quotesFile, []);
  quotes = quotes.filter(q => q.id !== id);
  writeData(quotesFile, quotes);
  res.json({ success: true, message: 'Quote deleted successfully' });
});

// API: Tracking Consignments
app.get('/api/tracking/:id', (req, res) => {
  const trackingId = (req.params.id || '').trim().toUpperCase();
  const trackingList = readData(trackingFile, []);
  
  const found = trackingList.find(t => 
    t.trackingId.toUpperCase() === trackingId ||
    t.trackingId.toUpperCase().replace('SCC-', '') === trackingId ||
    t.trackingId.toUpperCase() === `SCC-${trackingId}`
  );

  if (!found) {
    return res.status(404).json({
      success: false,
      error: `Consignment '${trackingId}' not found. Please try sample IDs like SCC-78291, SCC-55420, or SCC-99104.`
    });
  }

  res.json({ success: true, shipment: found });
});

// API: Contact Us Form
app.get('/api/contact', (req, res) => {
  const messages = readData(messagesFile, []);
  res.json(messages);
});

app.post('/api/contact', (req, res) => {
  const messages = readData(messagesFile, []);
  const { name, email, phone, subject, message } = req.body;

  if (!name || !phone || !message) {
    return res.status(400).json({ error: 'Name, Phone, and Message are required.' });
  }

  const newMsg = {
    id: `MSG-${Math.floor(100 + Math.random() * 900)}`,
    createdAt: new Date().toISOString(),
    name,
    email: email || '',
    phone,
    subject: subject || 'General Transport Inquiry',
    message
  };

  messages.unshift(newMsg);
  writeData(messagesFile, messages);

  res.status(201).json({
    success: true,
    message: 'Thank you for reaching out! Our dispatch coordinator will contact you shortly.',
    contact: newMsg
  });
});

// API: Dashboard Stats
app.get('/api/stats', (req, res) => {
  const quotes = readData(quotesFile, []);
  const messages = readData(messagesFile, []);
  const tracking = readData(trackingFile, []);

  const totalQuotes = quotes.length;
  const inTransit = quotes.filter(q => q.status === 'In Transit').length + tracking.filter(t => t.status === 'In Transit').length;
  const newRequests = quotes.filter(q => q.status === 'New').length;

  res.json({
    totalQuotes,
    newRequests,
    inTransit,
    totalMessages: messages.length
  });
});

// Fallback to index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`===================================================`);
  console.log(`🚛 Sachin Cargo Carriers Portal running on http://localhost:${PORT}`);
  console.log(`📍 Hub: Kattedan, Hyderabad, Telangana 500005`);
  console.log(`📞 Mobiles / WhatsApp: +91 88674 44552, +91 96323 69433`);
  console.log(`☎ Customer Care: +91 95054 44552`);
  console.log(`✉ Email: sachincargocarriers@gmail.com`);
  console.log(`===================================================`);
});
