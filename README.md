# Random image app
## About the project.

<h3>English</h3>
In that application I desided to make a custom servise which can directly take a random image with some info from unisplash.com and present it to user.</br>
In this app user can see random images. The image will change to a new one by timer.</br>
Also user can add image which they liked into favorites and see it in another screen.</br>
Also user can delete images from favorites.</br>

<h3>Russian</h3>
В этом приложении я решил создать специальный сервис, который может напрямую брать случайное изображение с некоторой информацией с unisplash.com и представлять его пользователю.</br>
В этом приложении пользователь может видеть случайные изображения. Изображение будет изменяться на новое по таймеру</br>
Также пользователь может добавить понравившееся изображение в избранное и просмотреть его на другом экране.</br>
также пользователь может удалять изображения из избранного</br>

## Used technoligies
- Drag and drop is implemented with native html5 drag and drop api with @drag, @dragend, @dragenter eventlisteners on the Card.vue component.
- Libraries like Vue.draggable were not used as i had to write most of the drag and drop logic according to the solitaire game type and I also had to **MOVE** the stack of cards.
- Ghost image in drag is removed instead the **whole stack** of card moves with cursor change.
