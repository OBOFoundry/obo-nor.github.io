dashboard/ ontologies/:
	mkdir -p $@

.PRECIOUS: dependencies
dependencies:
	#pip install networkx==2.6.2
	echo "No dependencies needed."

.PRECIOUS: run_dashboard
run_dashboard: | dependencies dashboard/ ontologies/
	obodash -C dashboard-config.yml