let user=document.querySelector('form input[ng-model=username]');
let pass=document.querySelector('form input[type=password]');
user.value = '§current_user_username§';
pass.value = '§current_user_password§';
angular.element(user).triggerHandler('change')
angular.element(pass).triggerHandler('change')
angular.element(document.forms[0]).triggerHandler('submit')
