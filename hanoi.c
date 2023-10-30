#include <stdio.h>
#include <stdlib.h>

#define DISCOS 3

struct nodo {
	int dato;
	int precedencia;
	struct nodo *previo;
};
typedef struct nodo * apuntanodo;
struct stack {
	int tam;
	apuntanodo tope;
};
typedef struct stack * apuntastack;
apuntastack creastack();
void push(apuntastack stk, int dato);
int pop(apuntastack stk);
void hanoiTowers(int n, apuntastack src, apuntastack aux, apuntastack dst);
int vacio(apuntastack stk);
void printDisks(apuntastack A, apuntastack C, apuntastack B);

int main() {
    apuntastack torre_A = creastack();
    apuntastack torre_B = creastack();
    apuntastack torre_C = creastack();
    printf("Agregando discos a la torre inicial");
    for(int i = DISCOS; i >= 1; i--){
        push(torre_A, i);
    }
    printDisks(torre_A,torre_C,torre_B);
    hanoiTowers(DISCOS,torre_A,torre_C,torre_B);

}

void printDisks(apuntastack A, apuntastack C, apuntastack B) {
    printf("\n------- CURRENT STATE -------\n\n");
    apuntanodo current = A->tope;
    while (current) {
        printf(" %d", current->dato);
        current = current->previo;
    }
    printf("|");
    printf("\n");
    current = B->tope;
    while (current) {
        printf(" %d", current->dato);
        current = current->previo;
    }
    current = C->tope;
    printf("|");
    printf("\n");
    while (current) {
        printf(" %d", current->dato);
        current = current->previo;
    }
    printf("|");
}

void hanoiTowers(int n, apuntastack src, apuntastack dst, apuntastack aux) {
    if (n == 1) {
        int disco = pop(src);
        push(dst,disco);
        printf("\n\nMoving %d\n",disco);
        printDisks(src,dst,aux);
        return;
    }
    hanoiTowers(n-1,src,aux,dst);
    int disco = pop(src);
    push(dst,disco);
    printf("\n\nMoving %d",disco);
    printDisks(src,dst,aux);
    hanoiTowers(n-1,aux,dst,src);
}

void push(apuntastack stk, int dato){
	apuntanodo nuevonodo = malloc(sizeof(struct nodo));
	nuevonodo->dato = dato;
	nuevonodo->previo = stk->tope;
	stk->tope = nuevonodo;
	stk->tam++;
}
int pop(apuntastack stk){
	apuntanodo borra = malloc(sizeof(struct nodo));
	int reg = stk->tope->dato;
	stk->tope=stk->tope->previo;
	stk->tam--,
	free(borra);
	return(reg);
}
apuntastack creastack(){
	apuntastack nuevo = malloc(sizeof(struct stack));
	nuevo->tam = 0;
	nuevo->tope = NULL;
	return nuevo;
}