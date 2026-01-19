# Ziran Web - Gestão de Consumíveis (MVP) 🛠️

Sistema PWA desenvolvido em Flutter para otimização do fluxo de reposição de consumíveis industriais. O projeto visa substituir processos manuais por um fluxo digital auditável via QR Code.



## 📋 O Problema vs. A Solução

* **Problema:** Atrasos na comunicação entre a manutenção e o almoxarifado, falta de rastreabilidade nos pedidos e erro humano na contagem de itens.
* **Solução:** Fluxo simplificado onde o repositor identifica o ponto via QR Code, o separador recebe a demanda em tempo real e o coordenador monitora gargalos via Dashboard.

## 🚀 Fluxo Operacional (Pautado)

1.  **Acesso:** Login via Matrícula/PIN (Segurança de Mercado).
2.  **Identificação:** Leitura de QR Code no posto (ex: Manutenção I).
3.  **Requisição:** Seleção de itens e quantidades.
4.  **Logística:** O pedido entra na "Fila de Separação" com status `ABERTO`.
5.  **Ciclo de Vida:** `ABERTO` ➔ `EM_SEPARACAO` ➔ `SEPARADO` ➔ `ENTREGUE`.

## 🛠️ Stack Tecnológica

* **Frontend:** [Flutter](https://flutter.dev) (Web/PWA)
* **Gerenciamento de Estado:** [Riverpod](https://riverpod.dev) (Reatividade Sênior)
* **Navegação:** [GoRouter](https://pub.dev/packages/go_router) (Rotas declarativas e dinâmicas)
* **Scanner:** `mobile_scanner` (Integração com câmera nativa)
* **Design:** Material Design 3 (Responsividade Total para Celular/Tablet/Desktop)

## 📁 Estrutura do Projeto (Clean Architecture)

```text
lib/
├── core/       # Configurações globais (Rotas, Temas)
├── models/     # Entidades de negócio (Pedido, Item, Status)
├── providers/  # Lógica de estado e regras de negócio (Riverpod)
├── screens/    # Interfaces de usuário (Login, Home, Point...)
└── widgets/    # Componentes reutilizáveis (Cards, Botões)