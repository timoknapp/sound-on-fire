# OkHttp 3.x (pulled in by AppUpdater) references optional classes that are not on the classpath.
# These are the rules OkHttp itself documents; the code paths are only used when the classes exist.
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
