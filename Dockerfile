FROM alpine:latest AS build
RUN apk add bash
RUN bash -c 'printf "#pragma once\ninline const char* const kUname = \"%q\";\n" "$(uname -a)"' | sed 's/\\\ / /g' >uname.h
RUN apk add g++
COPY ./hw.cc /
RUN g++ -static hw.cc -o hw

FROM alpine:latest
COPY --from=build /hw /hw
ENTRYPOINT ["/hw"]
