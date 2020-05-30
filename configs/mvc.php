<?php
return [
	//events
	\Controllers\EventsController::class=>\DI\autowire(),
	\Views\EventsView::class=>\DI\autowire(),

	//tops
	\Controllers\TopsController::class=>\DI\autowire(),
	\Views\TopsView::class=>\DI\autowire(),

	//olezha
	\Controllers\OlezhaController::class=>\DI\autowire(),
	\Views\OlezhaView::class=>\DI\autowire(),

	//olezha
	\Controllers\ChannelController::class=>\DI\autowire(),
	\Views\ChannelView::class=>\DI\autowire(),

	//users
	\Models\UserModel::class=>\DI\autowire()
];