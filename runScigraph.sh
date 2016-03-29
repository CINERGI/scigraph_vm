export MAVEN_OPTS='-server -d64 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:+UseBiasedLocking -XX:NewRatio=2 -Xms4G -Xmx4G '
sudo rm -r /var/scigraph-services/graph/*
cd SciGraph/SciGraph-core
 mvn exec:java --quiet -Dexec.mainClass="io.scigraph.owlapi.loader.BatchOwlLoader" -Dexec.args="-c ../../resources/cinergiExample.yml"     
 cd ../SciGraph-services
 mvn exec:java  -Dexec.mainClass="io.scigraph.services.MainApplication" -Dexec.args="server ../../resources/configuration.yml" &
