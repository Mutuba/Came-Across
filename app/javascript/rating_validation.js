document.addEventListener("DOMContentLoaded", function () {
  // Get all the rating input fields
  const ratingInputs = document.querySelectorAll(".rating-input");

  // Add an event listener to each input field
  ratingInputs.forEach(function (input) {
    input.addEventListener("input", function () {
      const inputValue = parseInt(input.value);
      const maxRating = 5;

      if (isNaN(inputValue) || inputValue < 1) {
        input.value = "";
      } else if (inputValue > maxRating) {
        input.value = maxRating;
      }
    });
  });
});
