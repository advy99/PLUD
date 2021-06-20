OUT = ./out

TEX_FILE = PLUD_entrega_final.tex
OUT_NAME = $(strip $(OUT))$(strip $(basename $(TEX_FILE))).pdf

.PHONY = all clean crear_carpetas

TEXCC = pdflatex
TEXCCFLAGS = -output-directory=$(OUT)

CARPETA_ENCONTRADA = $(wildcard $(OUT))

FICHEROS_TEX = $(wildcard src/*)

all: crear_carpetas $(OUT_NAME) demo

$(OUT_NAME) : $(TEX_FILE) $(FICHEROS_TEX)
	$(TEXCC) $(TEXCCFLAGS) $(TEX_FILE)
	# volvemos a compilar, para que genere bien el indice
	$(TEXCC) $(TEXCCFLAGS) $(TEX_FILE)


clean:
	-rm -I $(OUT)/*

crear_carpetas:
	-@mkdir -p $(OUT)
