// 🔹 Prima parte: buildscript per i plugin globali
buildscript {
    repositories {
        google()
        mavenCentral()
    }
}

// 🔹 Repositories globali per tutti i subproject
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 🔹 Allineamento cartelle build
val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

// 🔹 Task di pulizia
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
