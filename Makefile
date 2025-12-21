# ==================================================================================
# SO_LONG - MAKEFILE
# ==================================================================================

# ----------------- NOMES DOS EXECUTÁVEIS -----------------
NAME        = so_joao

# ----------------- COMPILADOR E FLAGS -----------------
CC          = gcc
CFLAGS      = -Wall -Wextra -Werror -g
LDFLAGS     = -no-pie
INCLUDES    = -Iincludes -I$(MLX_DIR) -I$(LIBFT_DIR)/include

# ----------------- DIRETÓRIOS -----------------
LIBFT_DIR   = libft
MLX_DIR     = minilibx
SRCS_DIR    = srcs
OBJ_DIR     = .objects

# ----------------- BIBLIOTECAS -----------------
LIBFT       = $(LIBFT_DIR)/libft.a
MLX         = $(MLX_DIR)/libmlx.a
MLX_FLAGS   = -L$(MLX_DIR) -lmlx -lXext -lX11 -lm
LIBFT_FLAGS = -L$(LIBFT_DIR) -lft

# ----------------- ARQUIVOS FONTE (MANDATORY) -----------------
SRCS        = $(SRCS_DIR)/main.c \
              $(SRCS_DIR)/map_parsing.c \
              $(SRCS_DIR)/map_validation.c \
              $(SRCS_DIR)/map_validation_utils.c \
              $(SRCS_DIR)/map_flood_fill.c \
              $(SRCS_DIR)/game_init.c \
              $(SRCS_DIR)/animation.c \
              $(SRCS_DIR)/enemies.c \
              $(SRCS_DIR)/enemies_utils.c \
              $(SRCS_DIR)/ui.c \
              $(SRCS_DIR)/ui_utils.c \
              $(SRCS_DIR)/game_events.c \
              $(SRCS_DIR)/map_utils.c \
              $(SRCS_DIR)/cleanup.c \
              $(SRCS_DIR)/exit.c \
              $(SRCS_DIR)/load_sprites.c

# ----------------- ARQUIVOS OBJETO -----------------
OBJS        = $(SRCS:$(SRCS_DIR)/%.c=$(OBJ_DIR)/%.o)

# ----------------- CORES PARA OUTPUT -----------------
GREEN       = \033[0;32m
YELLOW      = \033[0;33m
RED         = \033[0;31m
RESET       = \033[0m

# ==================================================================================
# REGRAS PRINCIPAIS
# ==================================================================================

all: $(NAME)

$(NAME): $(LIBFT) $(MLX) $(OBJS)
	@echo "$(YELLOW)Linking $(NAME)...$(RESET)"
	@$(CC) $(CFLAGS) $(OBJS) $(MLX_FLAGS) $(LIBFT_FLAGS) $(LDFLAGS) -o $(NAME)
	@echo "$(GREEN)✓ SUCCESS: $(NAME) created$(RESET)"

# ----------------- COMPILAÇÃO DE OBJETOS (MANDATORY) -----------------
$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	@echo "$(YELLOW)Compiling $<...$(RESET)"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# ----------------- BIBLIOTECAS -----------------
$(LIBFT):
	@echo "$(YELLOW)Building libft...$(RESET)"
	@$(MAKE) -C $(LIBFT_DIR) --no-print-directory
	@echo "$(GREEN)✓ libft compiled$(RESET)"

$(MLX):
	@echo "$(YELLOW)Building minilibx...$(RESET)"
	@$(MAKE) -C $(MLX_DIR) --no-print-directory 2>/dev/null || true
	@echo "$(GREEN)✓ minilibx compiled$(RESET)"

# ==================================================================================
# REGRAS DE LIMPEZA
# ==================================================================================

clean:
	@echo "$(RED)Cleaning object files...$(RESET)"
	@rm -rf $(OBJ_DIR)
	@$(MAKE) -C $(LIBFT_DIR) clean --no-print-directory
	@$(MAKE) -C $(MLX_DIR) clean --no-print-directory 2>/dev/null || true
	@echo "$(GREEN)✓ Object files removed$(RESET)"

fclean: clean
	@echo "$(RED)Removing executables...$(RESET)"
	@rm -f $(NAME)
	@$(MAKE) -C $(LIBFT_DIR) fclean --no-print-directory
	@echo "$(GREEN)✓ Executables removed$(RESET)"

re: fclean all

# ==================================================================================
# PHONY
# ==================================================================================

.PHONY: all clean fclean re
