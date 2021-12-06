# Random image app

## About the project / О проекте

###### English
In that application I desided to make a custom servise which can directly take a random image with some info from unsplash.com and present it to user.</br>
In this app user can see random images. The image will change to a new one by timer.</br>
Also user can add image which they liked into favorites and see it in another screen.</br>
Also user can delete images from favorites.</br>

###### Russian
В этом приложении я решил создать специальный сервис, который может напрямую брать случайное изображение с некоторой информацией с unsplash.com и представлять его пользователю.</br>
В этом приложении пользователь может видеть случайные изображения. Изображение будет изменяться на новое по таймеру.</br>
Также пользователь может добавить понравившееся изображение в избранное и просмотреть его на другом экране.</br>
Также пользователь может удалять изображения из избранного.</br>

## Previews / Превью
| Change image by timer /</br> Смена изображения по таймеру | Check if image already in DB /</br> Проверка наличия изображения в БД |
|:-------------:|:-------------:|
|<img  src="./readme_assets/change_by_timer.gif" width="70%">|<img  src="./readme_assets/checking_if_image_is_already_in_db.gif" width="70%">|

| Add to favorites / Добавление в избранное | Delete from favorites / Удаление из избранного |
|:-------------:|:-------------:|
|<img  src="./readme_assets/adding_image_to_favorites.gif" width="70%">|<img  src="./readme_assets/deleting_image_from_favorites.gif" width="70%">|

## Technologies used / Используемые технологии
- Swift
- UIKit without any storyboards (programmatically)
- Core Data
- Unsplash.com JSON API
- GSD
- ARC

## Improvement plans / Планы по доработке

###### English
I just finished writing some code. In it, you can notice that I used the MVP architecture at first, but then you will see noodles. So:
- I have to do a pure power MVP
- The application lacks element animation (fade in, fade out, and so on)
- Unit tests weren't written either.
</p>Actually, these three tasks I have to solve</p>

###### Russian
Я только что закончил писать код. В нем вы можете заметить, что я сначала использовал архитектуру MVP, но потом вы увидите лапшу. Так что:
- Мне нужно сделать MVP в чистом виде
- В приложении отсутствует анимация элементов (нарастание, затухание и т. д.)
- Юнит-тесты тоже не были написаны.
<p>Собственно, эти три задачи мне предстоит решить.</p>
