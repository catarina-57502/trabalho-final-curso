# bag-of-spells

Not much here, just spells in a bag, in the sense of lisperati - casting spels in lisp.

## TODO

* authentication (see net.lisp)
* database (for now uses json files which translate directly to lisp objects - see resources.lisp)
* [www] add new user / event

* (wip) multi-container Docker using Common-Lisp to implement a full web application with a mongoDB database.

## Instructions

### Using sbcl directly

* Install sbcl and quicklisp

* Ensure that the link of the project is in local-projects of quicklisp:

> mklink /J c:\home\quicklisp\local-projects\bag-of-spells c:\home\projects\bag-of-spells

In emacs run sly (or slime) and then, in the repl:

> (ql:quickload :bag)
>
> (bag:run)


### Using docker and docker compose

In file .env update / change accordingly:

> 'SBCL_VERSION'
>
> 'PROJECT_NAME'

Then, in a shell, do:

> docker compose build
>
> docker compose up -d

To shutdown, in a shell do:

> docker compose down --volumes

In emacs run sly-connect (or slime-connect) with all default settings and then, in the repl do:

> (ql:quickload :bag)
>
> (bag:run)


## Notes

* If one changes the name of the system, ensure that read.resources is update (:bag -> :something-else)

* To display debug messages using hunchentoot use:

> (hunchentoot::log-message* :warning "hello ~a" "world!")
