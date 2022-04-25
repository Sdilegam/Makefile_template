# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sdi-lega <sdi-lega@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/25 11:25:36 by sdi-lega          #+#    #+#              #
#    Updated: 2022/04/25 15:47:53 by sdi-lega         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#																			   #
#									VARIABLES								   #
#																			   #
################################################################################

NAME				=	#Name of project.

#####################################
#									#
#			Directories				#
#									#
#####################################

#Common#
COMN_DIR			=	sources/common/
COMN_OBJ_DIR		=	${COMMON_DIR}objects/

#Mandatory#
MANDA_DIR			=	sources/mandatory/
MANDA_OBJ_DIR		=	${MANDATORY_DIR}objects/

#Bonus#
BONUS_DIR			=	sources/bonus/
BONUS_OBJ_DIR		=	${BONUS_DIR}objects/

#Other#
LIB_DIR		=	libraries/

#####################################
#									#
#			Sources & objects		#
#									#
#####################################

#Common#
COMN_SRCS			=	\

COMN_OBJS			=	${addprefix ${COMN_OBJ_DIR}, ${COMN_SOURCES:.c=.o}}
COMN_LIBS			=	#Libs for comon sources

#Mandatory#
MANDA_SRCS			=	\

MANDA_OBJS			=	${addprefix ${MANDA_OBJ_DIR}, ${MANDA_SOURCES:.c=.o}}
MANDA_LIBS			=	${COMN_LIBS}#Libs for mandatory sources

#Bonus#
BONUS_SRCS			=	\

BONUS_OBJS			=	${addprefix ${BONUS_OBJ_DIR}, ${BONUS_SRCS:.c=.o}}
BONUS_LIBS			=	${COMN_LIBS}#Libs for bonus sources

ALL_LIBS			=	${COMN_LIBS} ${MANDA_LIBS} ${BONUS_LIBS}
DEPENDS				=	${OBJECTS:.o=.d} ${BONUS_OBJECTS:.o=.d} ${COMN_OBJECTS:.o=.d}
EXECUTABLES			=	${NAME} ${NAME}_bonus #Modify if other executables needed#

#####################################
#									#
#				OTHERS				#
#									#
#####################################

CC					=	gcc
COMN_INCLUDE		=	-Iincludes -I${COMN_DIR}headers/ ${addprefix -I, ${addprefix ${LIB_DIR},${dir ${COMN_LIBS}}}}
MANDA_INCLUDE		=	-I${MANDA_DIR}headers/ ${addprefix -I, ${addprefix ${LIB_DIR},${dir ${MANDA_LIBS}}}}                                                         
BONUS_INCLUDE		=	-I${BONUS_DIR}headers/ ${addprefix -I, ${addprefix ${LIB_DIR},${dir ${BONUS_LIBS}}}}

CC_FLAGS			=	${COMN_INCLUDE} -MMD -Wall -Werror -Wextra
RM					=	rm -f
SLEEP_TIME			=	0.2
SILENT				=	@

################################################################################
#																			   #
#										RULES								   #
#																			   #
################################################################################

#####################################
#									#
#				GENERAL				#
#									#
#####################################

all:				mandatory #bonus
re:					fclean all

mandatory:			${NAME}
bonus:				${NAME}_bonus

#####################################
#									#
#				COMPILING			#
#									#
#####################################

#OBJECTS#
${COMN_OBJ_DIR}%.o:	${addprefix ${COMN_DIR}, %.c}
			@ echo  "\rCreating common \"${@F:.c=.o}\" object file.\033[K\c"
			${SILENT} ${CC} ${CC_FLAGS} ${COMN_INCLUDE} -c $< -o ${COMN_OBJ_DIR}${@F:.c=.o}
			@ sleep ${SLEEP_TIME}
			
${MANDA_OBJ_DIR}%.o:	${addprefix ${MANDA_DIR}, %.c}
			@ echo  "\rCreating mandatory \"${@F:.c=.o}\" object file.\033[K\c"
			${SILENT} ${CC} ${CC_FLAGS} ${MANDA_INCLUDE} -c $< -o ${MANDA_OBJ_DIR}${@F:.c=.o}
			@ sleep ${SLEEP_TIME}
			
${BONUS_OBJ_DIR}%.o:	${addprefix ${BONUS_DIR}, %.c}
			@ echo  "\rCreating bonus \"${@F:.c=.o}\" object file.\033[K\c"
			${SILENT} ${CC} ${CC_FLAGS} ${BONUS_INCLUDE} -c $< -o ${BONUS_OBJ_DIR}${@F:.c=.o}
			@ sleep ${SLEEP_TIME}
			
#LIBS#	
${addprefix ${LIB_DIR}, ${ALL_LIBS}}:		
			@ echo  "\rCreating \"${notdir $@}\".\033[K\c"
			${SILENT} make -sC $(@D)
			@ echo "\rLibrary \"${notdir $@}\" created\033[K"

#EXECUTABLES#
${NAME}:				${OBJECTS_DIR} ${addprefix ${LIB_DIR}, ${MANDA_LIBS}} ${COMN_OBJS} ${MANDA_OBJS}
			@ echo "\r\"$@\" executable created\033[K"
			${SILENT} ${CC} ${addprefix -L, ${addprefix ${LIB_DIR},${dir ${MANDA_LIBS}}}} ${addprefix -l, ${patsubst lib%.a, %, ${notdir ${MANDA_LIBS}}}} ${COMN_OBJS} ${MANDA_OBJS} -o $@
			@ sleep ${SLEEP_TIME}
			
${NAME}_bonus:			${BONUS_OBJECTS_DIR} ${addprefix ${LIB_DIR}, $b}}${COMN_OBJS} ${BONUS_OBJS}
			@ echo "\r\"$@\" executable created\033[K"
			${SILENT} ${CC} ${addprefix -L, ${addprefix ${LIB_DIR},${dir ${BONUS_LIBS}}}} ${addprefix -l, ${patsubst lib%.a, %, ${notdir ${BONUS_LIBS}}}} ${COMN_OBJS} ${BONUS_OBJS} -o $@
			@ sleep ${SLEEP_TIME}

			
-include ${DEPENDS}

#####################################
#									#
#				CLEANING			#
#									#
#####################################

clean:
			@ echo "\rRemoving objects files (${notdir ${COMN_OBJS}} ${notdir ${MANDA_OBJS}}).\033[K\c"
			${SILENT} ${RM} ${OBJECTS} ${COMN_OBJS} ${DEPENDS}
			@ sleep ${SLEEP_TIME}

clean_bonus:
			@ echo "\rRemoving bonnus objects files (${notdir ${BONUS_OBJS}}).\033[K\c"
			${SILENT} ${RM} ${BONUS_OBJS} ${DEPENDS}
			@ sleep ${SLEEP_TIME}

${addprefix clean_,${dir ${ALL_LIBS}}}:
			@ echo "\rRemoving libraries (${patsubst clean_%,%, $@}).\033[K\c"
			${SILENT} make clean -sC ${patsubst clean_%, libraries/%, $@}
			@ sleep ${SLEEP_TIME}

clean_exe:
			@ echo "\rRemoving executables (${notdir ${EXECUTABLES}}).\033[K\c"
			${SILENT} ${RM} ${EXECUTABLES}
			@ sleep ${SLEEP_TIME}

fclean:			clean ${addprefix clean_,${dir ${ALL_LIBS}}} clean_exe clean_bonus
			@ echo "\rEverything removed.\033[K"
				
#####################################
#									#
#			INITIALIZATION			#
#									#
#####################################

${OBJECTS_DIR}:
			mkdir ${OBJECTS_DIR}
${BONUS_OBJECTS_DIR}:
			mkdir ${BONUS_OBJECTS_DIR}

start:				
			${SILENT} mkdir -p sources/common/objects
			${SILENT} mkdir -p sources/common/headers
			${SILENT} mkdir -p sources/mandatory/objects
			${SILENT} mkdir -p sources/mandatory/headers
			${SILENT} mkdir -p sources/bonus/objects
			${SILENT} mkdir -p sources/bonus/headers
			${SILENT} mkdir -p libraries

.phony: 	fclean clean clean_bonus clean_libs clean_exe start all mandatory bonus re 

