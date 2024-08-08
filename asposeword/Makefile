build:
	docker build -t office2pdf .
run:
	@docker rm -f aspoffice
	docker run --name aspoffice -d -p 5000:5000 -v $(pwd):/app office2pdf

test:
	curl -X POST http://116.236.69.90:5000/convert \
		-F "file=@供应链台账系统项目技术开发委托合同(1).doc" \
		-F "target_format=pdf" \
		-o outputfile.pdf
