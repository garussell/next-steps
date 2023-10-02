document.addEventListener('DOMContentLoaded', function () {

  const roleSelect = document.querySelector('#user-role'); 
  const descriptionField = document.querySelector('#agent-description'); 
  
  console.log('Initial account type:', roleSelect.value);
  
  roleSelect.addEventListener('change', function () {
    console.log('Selected account type:', roleSelect.value);
    
    if (roleSelect.value === 'agent') {
      descriptionField.style.display = 'block';
    } else {
      descriptionField.style.display = 'none';
    }
  });
});
