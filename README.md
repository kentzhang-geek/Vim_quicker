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

Use <C-J> To insert comment quickly
Use <C-L> To Highlight some word in current file buffer
Use <C-K> To execute some command and insert file head or function head and so on
		Use like this:
		step 1 : type "func" at line tail
		step 2 : press <C-K>
		setp 3 : input what a function head need
and you have this now:
<code>
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
</code>

Now wo can execute these command:
	config
	file
	func
	mds
	mde
	ads
	ade
	dt

Next step i will realize these commands:
-[] if
-[] while
-[] for
-[] if else
-[] { and }
-[] enum (typedef)
-[] struct (typedef)
-[] style
-[] logfile
-[] symbol lookup
