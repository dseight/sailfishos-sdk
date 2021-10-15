FROM ghcr.io/dseight/sailfishos-sdk-chroot:v4.2.0.21

ARG TARGETS_URL=https://releases.sailfishos.org/sdk/targets
ARG VERSION=4.2.0.21

COPY 0001-Allow-running-sdk-manage-as-root.patch \
     0001-Allow-running-sdk-manage-as-root.patch
RUN patch -p1 -d/ -i 0001-Allow-running-sdk-manage-as-root.patch

COPY 0002-Allow-running-sdk-assistant-as-root.patch \
     0002-Allow-running-sdk-assistant-as-root.patch
RUN patch -p1 -d/ -i 0002-Allow-running-sdk-assistant-as-root.patch

RUN sdk-assistant -y tooling create SailfishOS \
    $TARGETS_URL/Sailfish_OS-$VERSION-Sailfish_SDK_Tooling-i486.tar.7z

RUN sdk-assistant -y target create --no-snapshot SailfishOS-aarch64 \
    $TARGETS_URL/Sailfish_OS-$VERSION-Sailfish_SDK_Target-aarch64.tar.7z

RUN sdk-assistant -y target create --no-snapshot SailfishOS-armv7hl \
    $TARGETS_URL/Sailfish_OS-$VERSION-Sailfish_SDK_Target-armv7hl.tar.7z

RUN sdk-assistant -y target create --no-snapshot SailfishOS-i486 \
    $TARGETS_URL/Sailfish_OS-$VERSION-Sailfish_SDK_Target-i486.tar.7z
