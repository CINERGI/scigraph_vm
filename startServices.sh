export MAVEN_OPTS='-server -d64 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:+UseBiasedLocking -XX:NewRatio=2 -Xms4G -Xmx4G -XX:-ReduceInitialCardMarks'
cd SciGraph/SciGraph-services
mvn exec:java  -Dexec.mainClass="io.scigraph.services.MainApplication" -Dexec.args="server ../../resources/configuration.yml" &