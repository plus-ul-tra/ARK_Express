	
	hideAllForms();
function showForm(formId) {
    // 모든 form을 숨김
    hideAllForms();

    // 선택한 form을 보여줌
    document.getElementById(formId).style.display = 'block';
}

function hideAllForms() {
    // 모든 form을 숨김
    var forms = document.getElementsByTagName('form');
    for (var i = 0; i < forms.length; i++) {
        forms[i].style.display = 'none';
    }
}
