// Custom JavaScript for image attachments
document.addEventListener("trix-attachment-add", function (event) {
  if (event.attachment.file) {
    var file = event.attachment.file;
    var form_data = new FormData();
    form_data.append("file", file);

    fetch("/image_uploads", {
      method: "POST",
      body: form_data,
    })
      .then((response) => response.json())
      .then((data) => {
        event.attachment.setAttributes({
          url: data.url,
          href: data.url,
        });
      })
      .catch((error) => console.error("Image upload failed: ", error));
  }
});
