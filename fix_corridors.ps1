$file = "public\index.html"
$content = Get-Content $file -Raw -Encoding UTF8

# 1. Fix Mumbai corridor - add city bg image + Calculate button
$old1 = @'
        <!-- Corridor 2: Maharashtra (Mumbai & Pune) -->
        <div class="relative rounded-2xl border-2 border-sky-200 hover:border-sky-500 transition group shadow-sm flex flex-col justify-between overflow-hidden" style="min-height:340px;">
          <div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" style="background-image:url('https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=600&q=60')"></div>
          <div class="absolute inset-0 bg-gradient-to-b from-sky-50/90 via-white/85 to-white/95"></div>
          <div class="relative z-10 p-6 flex flex-col justify-between h-full">
'@

$new1 = @'
        <!-- Corridor 2: Maharashtra (Mumbai & Pune) -->
        <div class="relative rounded-2xl border-2 border-sky-200 hover:border-sky-500 transition group shadow-sm flex flex-col justify-between overflow-hidden" style="min-height:340px;">
          <div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" style="background-image:url('https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=600&q=60')"></div>
          <div class="absolute inset-0 bg-gradient-to-b from-sky-50/90 via-white/85 to-white/95"></div>
          <div class="relative z-10 p-6 flex-1">
'@

$content = $content.Replace($old1, $new1)

# 2. Fix Mumbai book button section
$old2 = @'
          <div class="pt-3 border-t border-slate-200 flex items-center justify-between">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-sky-600">&#x20B9;18,000</strong>
            </div>
            <a href="#quote" onclick="prefillCorridor('Mumbai &amp; Pune, Maharashtra')" class="px-3.5 py-1.5 rounded-xl bg-slate-900 hover:bg-sky-600 text-white text-xs font-bold transition flex items-center gap-1">
              Book Corridor <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
            </a>
          </div>
        </div>

        <!-- Corridor 3: Tamil Nadu (Chennai & Coimbatore) -->
        <div class="bg-slate-50 rounded-2xl p-6 border-2 border-emerald-200 hover:border-emerald-500 hover:bg-white transition group shadow-sm flex flex-col justify-between">
'@

$new2 = @'
          <div class="relative z-10 px-6 pb-6 pt-3 border-t border-slate-200 flex items-center justify-between bg-white/60">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-sky-600">&#x20B9;18,000</strong>
            </div>
            <div class="flex gap-1.5">
              <button onclick="bookServiceToCalc('Full Truck Load (FTL)','mumbai')" class="px-2.5 py-1.5 rounded-xl bg-sky-600 hover:bg-sky-700 text-white text-xs font-bold transition flex items-center gap-1 shadow">
                <i data-lucide="calculator" class="w-3 h-3"></i> Calc
              </button>
              <a href="#quote" onclick="prefillCorridor('Mumbai &amp; Pune, Maharashtra')" class="px-3 py-1.5 rounded-xl bg-slate-900 hover:bg-sky-600 text-white text-xs font-bold transition flex items-center gap-1">
                Book <i data-lucide="chevron-right" class="w-3 h-3"></i>
              </a>
            </div>
          </div>
        </div>

        <!-- Corridor 3: Tamil Nadu (Chennai & Coimbatore) -->
        <div class="relative rounded-2xl border-2 border-emerald-200 hover:border-emerald-500 transition group shadow-sm flex flex-col justify-between overflow-hidden" style="min-height:340px;">
          <div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" style="background-image:url('https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=600&q=60')"></div>
          <div class="absolute inset-0 bg-gradient-to-b from-emerald-50/90 via-white/85 to-white/95"></div>
          <div class="relative z-10 p-6 flex-1">
'@

$content = $content.Replace($old2, $new2)

# 3. Tamil Nadu book button
$old3 = @'
          <div class="pt-3 border-t border-slate-200 flex items-center justify-between">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-emerald-600">&#x20B9;17,200</strong>
            </div>
            <a href="#quote" onclick="prefillCorridor('Chennai &amp; Coimbatore, Tamil Nadu')" class="px-3.5 py-1.5 rounded-xl bg-slate-900 hover:bg-emerald-600 text-white text-xs font-bold transition flex items-center gap-1">
              Book Corridor <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
            </a>
          </div>
        </div>

        <!-- Corridor 4: Andhra Pradesh (Vijayawada & Vizag) -->
        <div class="bg-slate-50 rounded-2xl p-6 border-2 border-amber-200 hover:border-amber-500 hover:bg-white transition group shadow-sm flex flex-col justify-between">
'@

$new3 = @'
          <div class="relative z-10 px-6 pb-6 pt-3 border-t border-slate-200 flex items-center justify-between bg-white/60">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-emerald-600">&#x20B9;17,200</strong>
            </div>
            <div class="flex gap-1.5">
              <button onclick="bookServiceToCalc('Full Truck Load (FTL)','chennai')" class="px-2.5 py-1.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold transition flex items-center gap-1 shadow">
                <i data-lucide="calculator" class="w-3 h-3"></i> Calc
              </button>
              <a href="#quote" onclick="prefillCorridor('Chennai &amp; Coimbatore, Tamil Nadu')" class="px-3 py-1.5 rounded-xl bg-slate-900 hover:bg-emerald-600 text-white text-xs font-bold transition flex items-center gap-1">
                Book <i data-lucide="chevron-right" class="w-3 h-3"></i>
              </a>
            </div>
          </div>
        </div>

        <!-- Corridor 4: Andhra Pradesh (Vijayawada & Vizag) -->
        <div class="relative rounded-2xl border-2 border-amber-200 hover:border-amber-500 transition group shadow-sm flex flex-col justify-between overflow-hidden" style="min-height:340px;">
          <div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" style="background-image:url('https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?w=600&q=60')"></div>
          <div class="absolute inset-0 bg-gradient-to-b from-amber-50/90 via-white/85 to-white/95"></div>
          <div class="relative z-10 p-6 flex-1">
'@

$content = $content.Replace($old3, $new3)

# 4. AP book button  
$old4 = @'
          <div class="pt-3 border-t border-slate-200 flex items-center justify-between">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-amber-600">&#x20B9;8,500</strong>
            </div>
            <a href="#quote" onclick="prefillCorridor('Vijayawada &amp; Vizag, Andhra Pradesh')" class="px-3.5 py-1.5 rounded-xl bg-slate-900 hover:bg-amber-600 text-white text-xs font-bold transition flex items-center gap-1">
              Book Corridor <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
            </a>
          </div>
        </div>

        <!-- Corridor 5: Gujarat (Ahmedabad & Surat) -->
        <div class="bg-slate-50 rounded-2xl p-6 border-2 border-purple-200 hover:border-purple-500 hover:bg-white transition group shadow-sm flex flex-col justify-between">
'@

$new4 = @'
          <div class="relative z-10 px-6 pb-6 pt-3 border-t border-slate-200 flex items-center justify-between bg-white/60">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-amber-600">&#x20B9;8,500</strong>
            </div>
            <div class="flex gap-1.5">
              <button onclick="bookServiceToCalc('Full Truck Load (FTL)','vijayawada')" class="px-2.5 py-1.5 rounded-xl bg-amber-600 hover:bg-amber-700 text-white text-xs font-bold transition flex items-center gap-1 shadow">
                <i data-lucide="calculator" class="w-3 h-3"></i> Calc
              </button>
              <a href="#quote" onclick="prefillCorridor('Vijayawada &amp; Vizag, Andhra Pradesh')" class="px-3 py-1.5 rounded-xl bg-slate-900 hover:bg-amber-600 text-white text-xs font-bold transition flex items-center gap-1">
                Book <i data-lucide="chevron-right" class="w-3 h-3"></i>
              </a>
            </div>
          </div>
        </div>

        <!-- Corridor 5: Gujarat (Ahmedabad & Surat) -->
        <div class="relative rounded-2xl border-2 border-purple-200 hover:border-purple-500 transition group shadow-sm flex flex-col justify-between overflow-hidden" style="min-height:340px;">
          <div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" style="background-image:url('https://images.unsplash.com/photo-1587474260584-136574528ed5?w=600&q=60')"></div>
          <div class="absolute inset-0 bg-gradient-to-b from-purple-50/90 via-white/85 to-white/95"></div>
          <div class="relative z-10 p-6 flex-1">
'@

$content = $content.Replace($old4, $new4)

# 5. Gujarat book button
$old5 = @'
          <div class="pt-3 border-t border-slate-200 flex items-center justify-between">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-purple-600">&#x20B9;29,000</strong>
            </div>
            <a href="#quote" onclick="prefillCorridor('Ahmedabad &amp; Surat, Gujarat')" class="px-3.5 py-1.5 rounded-xl bg-slate-900 hover:bg-purple-600 text-white text-xs font-bold transition flex items-center gap-1">
              Book Corridor <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
            </a>
          </div>
        </div>

        <!-- Corridor 6: Delhi NCR (New Delhi, Gurugram, Okhla) -->
        <div class="bg-slate-50 rounded-2xl p-6 border-2 border-rose-200 hover:border-rose-500 hover:bg-white transition group shadow-sm flex flex-col justify-between">
'@

$new5 = @'
          <div class="relative z-10 px-6 pb-6 pt-3 border-t border-slate-200 flex items-center justify-between bg-white/60">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-purple-600">&#x20B9;29,000</strong>
            </div>
            <div class="flex gap-1.5">
              <button onclick="bookServiceToCalc('Full Truck Load (FTL)','ahmedabad')" class="px-2.5 py-1.5 rounded-xl bg-purple-600 hover:bg-purple-700 text-white text-xs font-bold transition flex items-center gap-1 shadow">
                <i data-lucide="calculator" class="w-3 h-3"></i> Calc
              </button>
              <a href="#quote" onclick="prefillCorridor('Ahmedabad &amp; Surat, Gujarat')" class="px-3 py-1.5 rounded-xl bg-slate-900 hover:bg-purple-600 text-white text-xs font-bold transition flex items-center gap-1">
                Book <i data-lucide="chevron-right" class="w-3 h-3"></i>
              </a>
            </div>
          </div>
        </div>

        <!-- Corridor 6: Delhi NCR (New Delhi, Gurugram, Okhla) -->
        <div class="relative rounded-2xl border-2 border-rose-200 hover:border-rose-500 transition group shadow-sm flex flex-col justify-between overflow-hidden" style="min-height:340px;">
          <div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" style="background-image:url('https://images.unsplash.com/photo-1587474260584-136574528ed5?w=600&q=60')"></div>
          <div class="absolute inset-0 bg-gradient-to-b from-rose-50/90 via-white/85 to-white/95"></div>
          <div class="relative z-10 p-6 flex-1">
'@

$content = $content.Replace($old5, $new5)

# 6. Delhi book button
$old6 = @'
          <div class="pt-3 border-t border-slate-200 flex items-center justify-between">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-rose-600">&#x20B9;38,000</strong>
            </div>
            <a href="#quote" onclick="prefillCorridor('Delhi NCR (New Delhi / Gurugram / Okhla)')" class="px-3.5 py-1.5 rounded-xl bg-slate-900 hover:bg-rose-600 text-white text-xs font-bold transition flex items-center gap-1">
              Book Corridor <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
            </a>
          </div>
        </div>

      </div>
'@

$new6 = @'
          <div class="relative z-10 px-6 pb-6 pt-3 border-t border-slate-200 flex items-center justify-between bg-white/60">
            <div>
              <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
              <strong class="text-sm font-black text-rose-600">&#x20B9;38,000</strong>
            </div>
            <div class="flex gap-1.5">
              <button onclick="bookServiceToCalc('Full Truck Load (FTL)','delhi')" class="px-2.5 py-1.5 rounded-xl bg-rose-600 hover:bg-rose-700 text-white text-xs font-bold transition flex items-center gap-1 shadow">
                <i data-lucide="calculator" class="w-3 h-3"></i> Calc
              </button>
              <a href="#quote" onclick="prefillCorridor('Delhi NCR (New Delhi / Gurugram / Okhla)')" class="px-3 py-1.5 rounded-xl bg-slate-900 hover:bg-rose-600 text-white text-xs font-bold transition flex items-center gap-1">
                Book <i data-lucide="chevron-right" class="w-3 h-3"></i>
              </a>
            </div>
          </div>
        </div>

      </div>
'@

$content = $content.Replace($old6, $new6)

# 7. Add bookServiceToCalc JS function and vehicle image admin support
# Insert after handleHeroEstimate function - after transferEstimateToQuote function
$oldJS = @'
    // ==============================================================
    // 4. DYNAMIC SERVICES API & RENDERING (CUSTOMER PORTAL)
'@

$newJS = @'
    // bookServiceToCalc: "Book Service" or "Calculate" on cards pre-fills the calculator
    function bookServiceToCalc(serviceName, dropCityVal) {
      // 1. Set Service Type dropdown
      var svcSel = document.getElementById('quickService');
      if (svcSel) {
        for (var i = 0; i < svcSel.options.length; i++) {
          if (svcSel.options[i].value === serviceName) {
            svcSel.selectedIndex = i;
            break;
          }
        }
        // If not found in fixed list, add dynamically
        if (svcSel.value !== serviceName) {
          var opt = document.createElement('option');
          opt.value = serviceName;
          opt.text = serviceName;
          svcSel.appendChild(opt);
          svcSel.value = serviceName;
        }
      }
      // 2. Set Destination dropdown
      var dropSel = document.getElementById('quickDrop');
      if (dropSel && dropCityVal) {
        for (var j = 0; j < dropSel.options.length; j++) {
          if (dropSel.options[j].value === dropCityVal) {
            dropSel.selectedIndex = j;
            break;
          }
        }
      }
      // 3. Scroll to calculator and trigger calculation
      var calcSection = document.getElementById('calculator');
      if (calcSection) {
        calcSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
        setTimeout(function() {
          var form = document.getElementById('heroQuickEstimateForm');
          if (form) form.dispatchEvent(new Event('submit', { cancelable: true, bubbles: true }));
        }, 600);
      }
    }

    // ==============================================================
    // 4. DYNAMIC SERVICES API & RENDERING (CUSTOMER PORTAL)
'@

$content = $content.Replace($oldJS, $newJS)

# 8. Add vehicle image URL field in admin - update renderDynamicRoutes to show city bg if imageUrl present
$oldVehicleRender = @'
    function renderDynamicRoutes(routes) {
      const container = document.getElementById('dynamicRoutesGrid');
      if (!container || !routes.length) return;

      container.innerHTML = routes.map(r => {
        const placesPills = (r.famousPlaces || '').split(',').map(p => `
          <span class="px-2 py-0.5 rounded-md bg-white border border-slate-200 text-slate-800 text-[11px] font-semibold">${p.trim()}</span>
        `).join('');

        return `
          <div class="bg-slate-50 rounded-2xl p-6 border-2 border-slate-200 hover:border-brand-orange hover:bg-white transition group shadow-sm flex flex-col justify-between">
'@

$newVehicleRender = @'
    function renderDynamicRoutes(routes) {
      const container = document.getElementById('dynamicRoutesGrid');
      if (!container || !routes.length) return;

      container.innerHTML = routes.map(r => {
        const placesPills = (r.famousPlaces || '').split(',').map(p => `
          <span class="px-2 py-0.5 rounded-md bg-white border border-slate-200 text-slate-800 text-[11px] font-semibold">${p.trim()}</span>
        `).join('');

        const bgStyle = r.cityImageUrl ? `style="background-image:url('${r.cityImageUrl}')"` : '';
        const hasBg = r.cityImageUrl ? 'relative overflow-hidden' : '';

        return `
          <div class="bg-slate-50 rounded-2xl border-2 border-slate-200 hover:border-brand-orange transition group shadow-sm flex flex-col justify-between ${hasBg}" style="min-height:300px;">
            ${r.cityImageUrl ? `<div class="absolute inset-0 bg-cover bg-center opacity-10 group-hover:opacity-20 transition-opacity duration-500" ${bgStyle}></div><div class="absolute inset-0 bg-gradient-to-b from-orange-50/90 via-white/85 to-white/95"></div>` : ''}
            <div class="relative z-10 p-6 flex-1">
'@

$content = $content.Replace($oldVehicleRender, $newVehicleRender)

# Fix closing of dynamic route card to include relative z-10 for footer
$oldDynClose = @'
            <div class="pt-3 border-t border-slate-200 flex items-center justify-between">
              <div>
                <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
                <strong class="text-sm font-black text-brand-orange">${r.priceStarting || '&#x20B9;12,500'}</strong>
              </div>
              <a href="#quote" onclick="prefillCorridor('${r.destination}')" class="px-3.5 py-1.5 rounded-xl bg-slate-900 hover:bg-brand-orange text-white text-xs font-bold transition flex items-center gap-1">
                Book Corridor <i data-lucide="chevron-right" class="w-3.5 h-3.5"></i>
              </a>
            </div>
          </div>
        `;
'@

$newDynClose = @'
            </div>
            <div class="relative z-10 px-6 pb-6 pt-3 border-t border-slate-200 flex items-center justify-between bg-white/60">
              <div>
                <span class="text-[10px] text-slate-400 block uppercase font-semibold">Starting Freight</span>
                <strong class="text-sm font-black text-brand-orange">${r.priceStarting || '&#x20B9;12,500'}</strong>
              </div>
              <div class="flex gap-1.5">
                <button onclick="bookServiceToCalc('Full Truck Load (FTL)', '${(r.destination || '').toLowerCase().split(' ')[0]}')" class="px-2.5 py-1.5 rounded-xl bg-brand-orange hover:bg-brand-orangeHover text-white text-xs font-bold transition flex items-center gap-1 shadow">
                  <i data-lucide="calculator" class="w-3 h-3"></i> Calc
                </button>
                <a href="#quote" onclick="prefillCorridor('${r.destination}')" class="px-3 py-1.5 rounded-xl bg-slate-900 hover:bg-brand-orange text-white text-xs font-bold transition flex items-center gap-1">
                  Book <i data-lucide="chevron-right" class="w-3 h-3"></i>
                </a>
              </div>
            </div>
          </div>
        `;
'@

$content = $content.Replace($oldDynClose, $newDynClose)

# 9. Add City Image URL field to admin route form
$oldRtForm = @'
        destination: document.getElementById('rtDest').value.trim(),
        state: document.getElementById('rtState').value.trim(),
        famousPlaces: document.getElementById('rtPlaces').value.trim(),
'@

$newRtForm = @'
        destination: document.getElementById('rtDest').value.trim(),
        state: document.getElementById('rtState').value.trim(),
        famousPlaces: document.getElementById('rtPlaces').value.trim(),
        cityImageUrl: document.getElementById('rtCityImg') ? document.getElementById('rtCityImg').value.trim() : '',
'@

$content = $content.Replace($oldRtForm, $newRtForm)

Set-Content $file $content -Encoding UTF8
Write-Host "Done! All replacements applied."
