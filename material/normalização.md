
### **1ª Forma Normal (1FN)**  
**Objetivo:** Eliminar grupos repetitivos ou multivalorados, garantindo que cada coluna contenha apenas valores atômicos (não divisíveis).  

- **Regras:**  
  - Os dados devem estar em uma tabela bidimensional (linhas e colunas).  
  - Cada célula deve conter um único valor (não listas ou conjuntos).  
  - Cada registro deve ser único, identificado por uma chave primária.

**Exemplo (Não Normalizado):**  
| Cliente   | Telefones           |  
|-----------|---------------------|  
| João      | 1234, 5678          |  
| Maria     | 7890                |  

**1FN (Normalizado):**  
| Cliente   | Telefone |  
|-----------|----------|  
| João      | 1234     |  
| João      | 5678     |  
| Maria     | 7890     |  

---

### **2ª Forma Normal (2FN)**  
**Objetivo:** Eliminar dependências parciais, ou seja, garantir que cada coluna dependa completamente da chave primária.  

- **Regras:**  
  - Deve estar na 1ª Forma Normal.  
  - Cada atributo não-chave deve depender inteiramente da chave primária e não apenas de uma parte dela (no caso de chaves compostas).  

**Exemplo (1FN, mas não 2FN):**  
| Pedido_ID | Produto   | Preço  | Cliente   |  
|-----------|-----------|--------|-----------|  
| 1         | Caneta    | 2.00   | João      |  
| 2         | Lápis     | 1.50   | Maria     |  

**Problema:** O preço do produto depende apenas do Produto, não do Pedido_ID.  

**2FN (Normalizado):**  
_Tabela Produtos:_  
| Produto   | Preço  |  
|-----------|--------|  
| Caneta    | 2.00   |  
| Lápis     | 1.50   |  

_Tabela Pedidos:_  
| Pedido_ID | Produto   | Cliente   |  
|-----------|-----------|-----------|  
| 1         | Caneta    | João      |  
| 2         | Lápis     | Maria     |  

---

### **3ª Forma Normal (3FN)**  
**Objetivo:** Eliminar dependências transitivas, garantindo que as colunas dependam diretamente da chave primária.  

- **Regras:**  
  - Deve estar na 2ª Forma Normal.  
  - Nenhum atributo não-chave deve depender de outro atributo não-chave.

**Exemplo (2FN, mas não 3FN):**  
| Pedido_ID | Produto   | Categoria | Cliente   |  
|-----------|-----------|-----------|-----------|  
| 1         | Caneta    | Papelaria | João      |  
| 2         | Lápis     | Papelaria | Maria     |  

**Problema:** Categoria depende do Produto, não diretamente do Pedido_ID.  

**3FN (Normalizado):**  
_Tabela Produtos:_  
| Produto   | Categoria  |  
|-----------|------------|  
| Caneta    | Papelaria  |  
| Lápis     | Papelaria  |  

_Tabela Pedidos:_  
| Pedido_ID | Produto   | Cliente   |  
|-----------|-----------|-----------|  
| 1         | Caneta    | João      |  
| 2         | Lápis     | Maria     |  


### **Outras Formas Normais**
Além das três principais, existem formas normais mais avançadas, como:  
- **Forma Normal de Boyce-Codd (BCNF):** Resolve anomalias causadas por dependências funcionais complexas.  
- **4ª Forma Normal (4FN):** Trata de dependências multivaloradas.  
- **5ª Forma Normal (5FN):** Resolve problemas com junções complexas.

