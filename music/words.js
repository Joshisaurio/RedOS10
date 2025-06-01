let words = "";

for (const word of document.body.getElementsByClassName("wordsOnlyNodes")) {
    let text =  word.innerText.replace(".", "");
    if (text != "Music") {
        words += word.id + "\n" + text + "\n";
    }
}
const blob = new Blob([words], { type: "text/plain" });
const link = document.createElement("a");
link.href = URL.createObjectURL(blob);
link.download = document.getElementById("titleContainer").innerText.replace(/\.[^/.]+$/, "") + ".txt";
link.click();