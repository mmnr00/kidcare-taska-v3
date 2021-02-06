console.log("mus")

const ftsct = document.querySelector('#kid_ftsct')
const dvFtsct = document.querySelector('#dv-ftosct')
const fmFtsct = document.querySelector('#kid_ftosct')

if(ftsct.value == "Lain-lain")
  {
  	dvFtsct.style.display = ""
    fmFtsct.style.display = ""
    fmFtsct.disabled = ""
  }

ftsct.addEventListener("change", function() {
  if(ftsct.value == "Lain-lain")
  {
  	dvFtsct.style.display = ""
    fmFtsct.style.display = ""
    fmFtsct.disabled = ""
  } else {
  	dvFtsct.style.display = "none"
  	fmFtsct.style.display = "none"
  	fmFtsct.disabled = "disabled"
  }
});

const mmsct = document.querySelector('#kid_mmsct')
const dvMmsct = document.querySelector('#dv-mmosct')
const fmMmsct = document.querySelector('#kid_mmosct')

if(mmsct.value == "Lain-lain")
  {
  	dvMmsct.style.display = ""
    fmMmsct.style.display = ""
    fmMmsct.disabled = ""
  }

mmsct.addEventListener("change", function() {
  if(mmsct.value == "Lain-lain")
  {
  	dvMmsct.style.display = ""
    fmMmsct.style.display = ""
    fmMmsct.disabled = ""
  } else {
  	dvMmsct.style.display = "none"
  	fmMmsct.style.display = "none"
  	fmMmsct.disabled = "disabled"
  }
});

const oku = document.querySelector('#kid_oku')
const dvSoku = document.querySelector('#dv-soku')
const fmSoku = document.querySelector('#kid_soku')

if(oku.value != "No" && oku.value != "")
  {
    dvSoku.style.display = ""
    fmSoku.style.display = ""
    fmSoku.disabled = ""
  }

oku.addEventListener("change", function() {
  if(oku.value != "No")
  {
    dvSoku.style.display = ""
    fmSoku.style.display = ""
    fmSoku.disabled = ""
  } else {
    dvSoku.style.display = "none"
    fmSoku.style.display = "none"
    fmSoku.disabled = "disabled"
  }
});



