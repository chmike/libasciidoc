.PHONY: profile
## run the profilers on the parser
profile: generate-optimized
	@mkdir -p ./tmp/bench/reports
	@go test -cpuprofile=tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).cpu.prof \
		-memprofile tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).mem.prof \
		-bench=. \
		-benchtime=1x \
		github.com/bytesparadise/libasciidoc \
		-run=XXX
	@echo "generate CPU reports..."
	@go tool pprof -text -output=tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).cpu.txt \
		tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).cpu.prof
ifndef CI
	@go tool pprof -svg -output=tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).cpu.svg \
		tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).cpu.prof
endif
	@echo "generate memory reports"
	@go tool pprof -text -output=tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).mem.txt \
		tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).mem.prof
ifndef CI
	@go tool pprof -svg -output=tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).mem.svg \
		tmp/bench/reports/$(GIT_BRANCH_NAME)-$(GIT_COMMIT_ID_SHORT).mem.prof
endif

