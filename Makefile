PORTNAME=	paperless-ngx
DISTVERSIONPREFIX=	v
DISTVERSION=	1.17.4
CATEGORIES=	www
MASTER_SITES=	https://github.com/${PORTNAME}/${PORTNAME}/releases/download/v${DISTVERSION}/
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	freebsd@mail.tinsuke.com
COMMENT=	Document management system Web Service
WWW=	https://docs.paperless-ngx.com/

LICENSE=	GPLv3

RUN_DEPENDS=	\
		ImageMagick7>0:graphics/ImageMagick7 \
		gnupg>0:security/gnupg \
		icc-profiles-adobe-cs4>0:graphics/icc-profiles-adobe-cs4 \
		leptonica>0:graphics/leptonica \
		liberation-fonts-ttf>0:x11-fonts/liberation-fonts-ttf \
		lzlib>0:archivers/lzlib \
		mime-support>0:misc/mime-support \
		pngquant>0:graphics/pngquant \
		poppler-utils>0:graphics/poppler-utils \
		redis>0:databases/redis \
		tesseract>0:graphics/tesseract \
		unpaper>0:graphics/unpaper \
		zbar>0:graphics/zbar \
		${PYTHON_PKGNAMEPREFIX}numpy>0:math/py-numpy@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}scikit-learn>0:science/py-scikit-learn@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}scipy>0:science/py-scipy@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}sqlite3>0:databases/py-sqlite3@${PY_FLAVOR}

# python venv dependencies
RUN_DEPENDS+=	\
		cmake>0:devel/cmake \
		freetype2>0:print/freetype2 \
		pkgconf>0:devel/pkgconf \
		libxml2>0:textproc/libxml2 \
		libxslt>0:textproc/libxslt \
		mysql80-client>0:databases/mysql80-client \
		postgresql16-client>0:databases/postgresql16-client \
		qpdf>0:print/qpdf \
		rust>0:lang/rust

USES=	python:3.8-3.9 tar:xz
USE_PYTHON=	flavors
USE_RC_SUBR=	paperless

SUB_FILES=	\
		pkg-message \
		paperless_manage \
		setup_database.sh \
		setup_nltk.sh \
		setup_venv.sh

SUB_LIST=	\
		OPTDIR=${OPTDIR} \
		PYTHON_CMD=${PYTHON_CMD} \
		USER=${USERS} \
		GROUP=${GROUPS}

PLIST_SUB=	\
	USER=${USERS} \
	GROUP=${GROUPS} \
	OPTDIR=${OPTDIR}

WRKSRC=	${WRKDIR}/${PORTNAME}
OPTDIR=	/opt/paperless

USERS=	paperless
GROUPS=	paperless

NO_BUILD=	yes

do-install:
	cd ${WRKSRC} && ${COPYTREE_SHARE} src ${STAGEDIR}${OPTDIR}
	cd ${WRKSRC} && ${COPYTREE_SHARE} static ${STAGEDIR}${OPTDIR}
	${INSTALL_DATA} ${WRKSRC}/requirements.txt ${STAGEDIR}${OPTDIR}/requirements.txt
	${INSTALL_DATA} ${WRKSRC}/paperless.conf ${STAGEDIR}${OPTDIR}/paperless.conf.sample
	${INSTALL_DATA} ${WRKSRC}/gunicorn.conf.py ${STAGEDIR}${OPTDIR}/gunicorn.conf.py.sample
	${INSTALL_SCRIPT} ${WRKDIR}/paperless_manage ${STAGEDIR}${PREFIX}/bin/
	${INSTALL} -d -m 755 ${STAGEDIR}/${OPTDIR}/setup/
	${INSTALL_SCRIPT} ${WRKDIR}/setup_*.sh ${STAGEDIR}/${OPTDIR}/setup/
	${MKDIR} ${STAGEDIR}${OPTDIR}/consume
	${MKDIR} ${STAGEDIR}${OPTDIR}/data
	${MKDIR} ${STAGEDIR}${OPTDIR}/media

.include <bsd.port.mk>
