
.PHONY: up down createChannel deployCC config init benchmark

up:
	cd fabric-samples/test-network/ && ./network.sh up

down:
	cd fabric-samples/test-network/ && ./network.sh down

createChannel:
	cd fabric-samples/test-network/ && ./network.sh createChannel

deployCC:
	cd fabric-samples/test-network/ && ./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-go -ccl go

init:
	peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile $(shell pwd)/fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles $(shell pwd)/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles $(shell pwd)/fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"InitLedger","Args":[]}'

benchmark:
	npx caliper launch manager --caliper-workspace ./caliper-workspace --caliper-networkconfig networks/networkConfig.json --caliper-benchconfig benchmarks/myAssetBenchmark.yaml --caliper-flow-only-test --caliper-fabric-gateway-enabled --caliper-fabric-gateway-discovery