--- gunicorn.conf.py.orig	2024-04-15 12:54:03 UTC
+++ gunicorn.conf.py
@@ -11,7 +11,8 @@ timeout = 120
 preload_app = True
 
 # https://docs.gunicorn.org/en/stable/faq.html#blocking-os-fchmod
-worker_tmp_dir = "/dev/shm"
+# FreeBSD doesn't have a default tmpfs mount
+# worker_tmp_dir = "/dev/shm"
 
 
 def pre_fork(server, worker):
