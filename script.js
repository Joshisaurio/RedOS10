document.addEventListener("DOMContentLoaded", () => {
    function toggleMode(mode) {
        if (mode === "light") {
            document.documentElement.setAttribute("data-bs-theme", "light");
        } else if (mode === "dark") {
            document.documentElement.setAttribute("data-bs-theme", "dark"); 
        }
    }

    document.querySelector(".light-mode-switch").addEventListener("click", () => {
        toggleMode("light");
    });

    document.querySelector(".dark-mode-switch").addEventListener("click", () => {
        toggleMode("dark");
    });
});
