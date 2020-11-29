'use strict'

// const mainBody = document.querySelector('.main-body')
// const modal = document.querySelector('.show-modal')
// const tutSet = new Map([
// 	["Login & Update Center Details","_Gah_4WB_f8"],
// 	["Register Children By Parents","8TOnp3hLxFw1"],
// 	["Register Children By Admin","8TOnp3hLxFw2"],
// 	["Create Classrooms","8TOnp3hLxFw3"],
// 	])

// const arrTry = $anisf





// let tut_no = 1
// for (const [key,value] of tutSet){
// 	const html = `<button class="tut-btn-${tut_no}" style="display">${tut_no}. ${key}</button><p class="close-${tut_no} d-none">close</p><br><br>`
// 	mainBody.insertAdjacentHTML('beforeend',html);
// 	tut_no++
// 	// document.querySelector(`.tut-btn-${tut_no}`).addEventListener('click', function () {
// 	// 	console.log(`${key}`)
// 	// })
// }

// let tut_btn = 1
// for (const [key,value] of tutSet){
// 	document.querySelector(`.tut-btn-${tut_btn}`).addEventListener('click', function () {
// 		console.log(`${key}`)
// 		mainBody.classList.add("d-none")
// 		const html1 = `<button class="try2" style="display">${key}</button>
// 						<br><br>`
// 		mainBody.insertAdjacentHTML('beforebegin',html1)
// 	})
// 	tut_btn++
// }

// const closeBtn = document.querySelector('.close--1')

// closeBtn.addEventListener('click', function (){
// 	console.log('close')
// })

// mainBody.addEventListener('click', function (){
// 	mainBody.classList.remove("d-none")
// })

/////////// new ////////////////////

const btnTute = document.querySelectorAll('.btn-tute')
const mainBody = document.querySelector('.main-body')
const tutIfr = document.querySelector('.modal-ifr')
const divIfr = document.getElementById('div-ifr')
const closeBtn = document.querySelector('.close-modal')
console.log(closeBtn)

const closeModal = function (){
	tutIfr.src=""
	divIfr.classList.add('d-none')
}

for (let i = 0; i < btnTute.length; i++){

	btnTute[i].addEventListener('click', function (){
		// const html = `
		// <div id="ifr-${btnTute[i].id}">
		// <iframe class="" style="position:absolute" width="560" height="315" src="https://www.youtube.com/embed/${btnTute[i].id}" frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		// </div>
		// `
		divIfr.classList.remove('d-none')
		tutIfr.src = `https://www.youtube.com/embed/${btnTute[i].id}`	
		closeBtn.textContent = 'Close X'
		console.log('click')

		// mainBody.insertAdjacentHTML('afterbegin',html)
		
		

		//console.log(html)
	})

	// const mussss123 = document.getElementById(`ifr-${btnTute[i].id}`)
	// console.log(mussss123)

	document.addEventListener('keydown', function(e){
		console.log(e.key)
		console.log(tutIfr.src)
		if (e.key) {
			closeModal()
		} 
	})

	closeBtn.addEventListener('click', function (){
		closeModal()
	})

}














































