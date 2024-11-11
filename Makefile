BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
COMMIT := $(shell git log -1 --format='%H')
ifeq (,$(VERSION))
	VERSION := $(shell git describe --exact-match 2>/dev/null)
		ifeq (,$(VERSION))
    			VERSION := $(BRANCH)-$(COMMIT)
  		endif
endif
ldflags = -X github.com/cosmos/cosmos-sdk/version.Name=mini \
    -X github.com/cosmos/cosmos-sdk/version.AppName=minid \
    -X github.com/cosmos/cosmos-sdk/version.Version=$(VERSION) \
    -X github.com/cosmos/cosmos-sdk/version.Commit=$(COMMIT)
BUILD_FLAGS := -ldflags="$(ldflags)"
install:
	@echo "--> Installing minid with version: $(VERSION)"
	@go install $(BUILD_FLAGS) -mod=readonly ./cmd/minid
init: 
	./scripts/init.sh
setup:   
	./scripts/setup_checker.sh
start: 
	./scripts/start_checker.sh
end: 
	./scripts/end_checker.sh
exportGameResult:   
	./scripts/export_checker.sh
# test:
#  	./scripts/test_checker.sh