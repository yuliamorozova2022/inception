#from this image container will be created
FROM	alpine:3.16
#what sofware and how will be installed inside the nginx container
# 	you can't run application from RUN instruction straightforward.
#	CMD and ENTRYPOINT instructions are used for it
#	RUN creates a static layer, changes in that layer are writed to image
#	and CMD/ENTRYPOIN run smthg, but don't write changes to the image

#	apk - file manager(like apt). updates repos, updates old packages, installs
#	nginx without saving sources in cache
RUN	apk update && apk upgrade && apk add --no-cache nginx
# port for container communication and traffic
EXPOSE	443
#nginx will run not in the daemon mode (not like the background service)
CMD	["nginx", "-g", "daemon off;"]
