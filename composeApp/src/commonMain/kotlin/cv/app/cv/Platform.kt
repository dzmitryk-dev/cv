package cv.app.cv

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform