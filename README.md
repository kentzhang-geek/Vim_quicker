Vim Quicker
==========================================================
A vim plugin for C coder
----------------------------------------------------------

	/*********************************************************
	*	File Name   : README.md
	*	Project     : Vim_quicker
	*	Author      : Kent
	*	Data        : 2013年08月03日 星期六 22时51分26秒
	*	Description : This file describe what have i done
	*	              
	**********************************************************/

	/* Notice : This plugin only apply C language */
	/* Notice : change key map */
	<M-x> means press x and Alt at the same time
	<C-x> means press x and Ctrl at the same time
	if your use vim with graphic support, then
		Use <M-j> To insert comment quickly
		Use <M-l> To Highlight some word in current file buffer
		Use <M-i> To execute some command and insert file head or function head and so on
	if not,your need use Ctrl quick keys:
		Use <C-j> To insert comment quickly
		Use <C-l> To Highlight some word in current file buffer
		Use <C-k> To execute some command and insert file head or function head and so on
	Use like this:
		step 1 : type "func" at line tail
		step 2 : press <M-i> (or <C-k>)
		setp 3 : input what a function head need
	and you have this now:
	/*********************************************************
	*	Func Name   : execute command
	*	Project     : Vim_quicker
	*	Author      : Kent
	*	Data        : 2013年08月03日 星期六 22时59分36秒
	*	Description : 
	*	              
	**********************************************************/
	NONE execute command(NONE)
	{
	}

Now wo can execute these command:
*	config
*	file
*	func
*	mds
*	mde
*	ads
*	ade
*	dt
*	if
*	enum (typedef)
*	while
*	for
*	else
*	struct (typedef)
*	{ and }
*	add applye to gtest framework: TEST(x, y) or TEST_F(x, y)
*	now apply fill cpp #ifdef types
*	add support to c plus plus languane "class" key word
*	add my debug tag #ifdef __DEBUG__
*	add quick history record function
*	add cscope support for symbol lookup

Next step i will realize these commands:
*	style
*	logfile
