let skeleton = document.querySelectorAll(".skeleton")
let mode = document.querySelector(".top i")
let searchBox = document.querySelector(".search input")
let searchBtn = document.querySelector(".search i")
let cityName = document.querySelector(".cityName")
let temp = document.querySelector(".temp")
let humidity = document.querySelector(".humidity1")
let wind = document.querySelector(".wind1")
let weather = document.querySelector(".weather")

const apiKey = "ae341b6af4c3407a52be29480bba95ad"
const apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=";


let switchMode = function (switchMode) {
    mode.onclick = function () {
        document.body.classList.toggle("dark")
        if (document.body.classList.contains("dark")) {
            mode.classList = "fa-regular fa-sun"
        } else {
            mode.classList = "fa-solid fa-moon"
        }
    }
}

let onLoadFun = function (onLoadFun) {
    window.onload = function () {
        let time = new Date().getHours()
        if (time < 17 && time > 12 ) {
            document.body.classList.remove("dark")
        }else{
            document.body.classList.toggle("dark")
            mode.classList = "fa-regular fa-sun"
        }
        skeleton.forEach(item => {
            item.classList.remove("skeleton")
        })
    }
}

switchMode()
onLoadFun()

async function checkWeather(city) {
    const response = await fetch(apiUrl + city + `&appid=${apiKey}`)
    var data = await response.json();
    if (response.status == 404) {
        document.querySelector(".error").style.display = "block"
        weather.style.display = "none"
        skeleton.forEach(item => {
            item.classList.remove("skeleton")
        })
    } else {
        cityName.innerText = data.name
        temp.innerText = Math.round(data.main.temp)
        humidity.innerText = data.main.humidity
        wind.innerText = data.wind.speed
        weather.style.display = "flex"
        document.querySelector(".error").style.display = "none"
        skeleton.forEach(item => {
            item.classList.remove("skeleton")
        })
    }
}

searchBtn.addEventListener("click", function () {
    checkWeather(searchBox.value)
    skeleton.forEach(item => {
        item.classList.add("skeleton")
    })
})
searchBox.addEventListener("keyup", function (e) {
    if (e.keyCode == 13) {
        checkWeather(searchBox.value)
        skeleton.forEach(item => {
            item.classList.add("skeleton")
        })
    }
})