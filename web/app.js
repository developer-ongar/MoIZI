const compoundNameInput = document.getElementById('compoundName');
const searchButton = document.getElementById('
function fetchCompoundInfo() {
  const compoundName = compoundNameInput.value;
  const encodedCompoundName = encodeURIComponent(compoundName);
  const pubChemApiUrl = `https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/${encodedCompoundName}/record/PNG`;

  fetch(pubChemApiUrl)
    .then(response => {
      if (response.ok) {
        return response.blob();
      } else {
        throw new Error('Ошибка HTTP ' + response.status);
      }
    })
    .then(blob => {
      const compoundImage = document.createElement('img');
      compoundImage.src = URL.createObjectURL(blob);
      compoundImage.alt = compoundName;
      document.getElementById('imageContainer').appendChild(compoundImage);
      document.getElementById('messageContainer').innerHTML = '';
    })
    .catch(error => {
      document.getElementById('messageContainer').innerHTML = 'Ошибка: ' + error.message;
    });
}

searchButton.addEventListener('click', fetchCompoundInfo);
