# k8s_autoroldep
k8s auto rollback if failed deployment


-В данном проекте описывается создание docker image с приложениями разных версий, 
использовние image для k8s через kubectl,применение и обновленение deployment в k8s
а также автоматическое обновление deployment и rollback в случае deployment status is failed.
k8s_autoroldep/StepbyStep.txt --тут представлен листинг команд 

-создаём app с именем "demo" версии V2 в Eclipse 
	приложение лежит тут: k8s_autoroldep\app\V2

-создаём docker image с нашим app версии V2
	Итог: готовый docker image можно забарть командой: docker pull antoniosf100/mydemoapp:v2


-создаём app с именем "demo" версии V3 в Eclipse
	приложение лежит тут: k8s_autoroldep\app\V3
	

-создаём docker image с нашим app версии V3
	Итог: готовый docker image можно забарть командой: docker pull antoniosf100/mydemoapp:v3


-С Windows (host-машина)устанавливаем minikube через PowerShell 
    Итог: будет создана VM c minikube


-Доп_настройки.(Linux машина нам нужна для выполнения скрипта autoroll.sh
	-который проверяет состояние rollout и если оно не успешено , то делается rollback
	Итог: будет создан autoroll.sh
	Скрипт тут: k8s_autoroldep\kubdep\autoroll.sh

-установка версии V2 сервиса
	В итоге развёртывания будет доступен сервис с версией V2
	Manifest файл тут: k8s_autoroldep\kubdep\deployment.yaml
	http://<minikube ip>/demo/hello  (Вернёт Дату и время)
	http://<minikube ip>/demo/ping  (Вернёт pong)
	

-обновление версии до V3 сервиса
	В итоге развёртывания будет доступен сервис с версией V3
	Manifest файл тут: k8s_autoroldep\kubdep\deployment-update.yaml
	http://<minikube ip>/demo/hello  (Вернёт Дату и время , а также метку версии(в нашем случае V3))
	
	
-обновление версии до V1 ("битая" версия сервиса)
	В итоге развёртывания будет deployment status is failed.
	Manifest файл тут: k8s_autoroldep\kubdep\deployment-failed.yaml
	http://<minikube ip>/demo/hello  (Вернёт ошибку)
	
	
-откат сервиса к предыдущей версии (ручной откат , через выполнение команд).
	В итоге будет развёрнута версия deployment V3
	листинг команд тут : k8s_autoroldep/StepbyStep.txt
	

-откат сервиса к предыдущей версии (автоматический rollback через скрипт)(Linux машина)
	В итоге выполнения скрипта будет либо успешный rollout , либо rollback к предыдущей ревизии в случае если "deployment is failed"
	листинг команд тут : k8s_autoroldep/StepbyStep.txt
