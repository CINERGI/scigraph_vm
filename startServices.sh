export MAVEN_OPTS='-server -d64 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:+UseBiasedLocking -XX:NewRatio=2 -Xms4G -Xmx4G '
cd SciGraph/SciGraph-services
mvn exec:java  -Dexec.mainClass="edu.sdsc.scigraph.services.MainApplication" -Dexec.args="server ../../resources/configuration.yml" &
ls
