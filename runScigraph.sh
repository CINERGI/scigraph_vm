export MAVEN_OPTS='-server -d64 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:+UseBiasedLocking -XX:NewRatio=2 -Xms4G -Xmx4G -XX:-ReduceInitialCardMarks'
sudo rm -r /var/scigraph-services/graph/*
cd SciGraph/SciGraph-core
 mvn exec:java --quiet -Dexec.mainClass="edu.sdsc.scigraph.owlapi.loader.BatchOwlLoader" -Dexec.args="-c ../../resources/cinergiExample.yml"     
 cd ../SciGraph-services
 mvn exec:java  -Dexec.mainClass="edu.sdsc.scigraph.services.MainApplication" -Dexec.args="server ../../resources/configuration.yml" &
