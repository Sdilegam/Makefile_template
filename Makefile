# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sdi-lega <sdi-lega@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/25 11:25:36 by sdi-lega          #+#    #+#              #
#    Updated: 2022/03/25 15:36:07 by sdi-lega         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#																			   #
#									VARIABLES								   #
#																			   #
################################################################################

NAME			=	Template

#####################################
#									#
#			Directories				#
#									#
#####################################

SOURCES_DIR		=	sources/
SUB_DIR			=	mandatory/
OBJECTS_DIR		=	${SOURCES_DIR}${SUB_DIR}objects/
LIB_DIR			=	libraries/

#####################################
#									#
#			Sources & objects		#
#									#
#####################################

SOURCES			=	${NAME}.c#Files to compile#
OBJECTS 		=	${OBJECTS_DIR}${SOURCES:.c=.o}
DEPENDS			=	${OBJECTS:.o=.d}
LIBRARIES		=	#Libraries needed#
EXECUTABLES		=	${NAME} #Modify if other executables needed#

#####################################
#									#
#				OTHERS				#
#									#
#####################################

CC			=	gcc
CC_FLAGS		=	 -Iincludes -Wall -Werror -Wextra
RM			=	rm -f
SLEEP_TIME		=	0.2
SILENT			=	@


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

all:					mandatory bonus
${NAME}:				mandatory
re:					fclean all

mandatory:				${OBJECTS_DIR} ${EXECUTABLES}
bonus:					
			#Bonus rule 

#####################################
#									#
#				COMPILING			#
#									#
#####################################

${OBJECTS_DIR}%.o:	${SOURCES_DIR}${SUB_DIR}%.c
			${SILENT} echo  "\033[K\rCreating \"${@F:.c=.o}\".\c"
			${SILENT} ${CC} ${FLAGS} -MMD -c $< -o ${OBJECTS_FOLDER}${@F:.c=.o}
			${SILENT} sleep ${SLEEP_TIME}

${LIBRARIES}:		
			${SILENT} make -C $(@D)
			${SILENT} make clean -C $(@D)

${EXECUTABLES}:			${OBJECTS_DIR} ${OBJECTS} ${LIBRARIES}
			${SILENT} echo "\r\"$@\" executable created\033[K"
			${SILENT} ${CC} $^ -o $@
			${SILENT} sleep ${SLEEP_TIME}

-include ${DEPENDS}

#####################################
#									#
#				CLEANING			#
#									#
#####################################

clean:

			${SILENT} echo "\rRemoving objects files (${notdir ${OBJECTS}}).\033[K\c"
			${SILENT} ${RM} ${OBJECTS}
			${SILENT} sleep ${SLEEP_TIME}

clean_bonus:

			#${SILENT} echo "\rSwitching to bonus files.\033[K\c"
			#${SILENT} make clean SUFFIX=_bonus SUB_DIR=bonus/
			#${SILENT} make clean_exe SUFFIX=_bonus SUB_DIR=bonus/

clean_libs:

			${SILENT} echo "\rRemoving libraries (${notdir ${LIBRARIES}}).\033[K\c"
			${SILENT} ${RM} ${LIBRARIES}
			${SILENT} sleep ${SLEEP_TIME}

clean_exe:

			${SILENT} echo "\rRemoving executables (${notdir ${EXECUTABLES}}).\033[K\c"
			${SILENT} ${RM} ${EXECUTABLES} ${EXECUTABLES}
			${SILENT} sleep ${SLEEP_TIME}

fclean:			clean clean_libs clean_exe clean_bonus
			${SILENT} echo "\rEverything removed.\033[K"
				
#####################################
#									#
#			INITIALIZATION			#
#									#
#####################################

${OBJECTS_DIR}:
			mkdir ${OBJECTS_DIR}

start:				
			${SILENT} mkdir -p sources/mandatory/objects
			${SILENT} mkdir -p sources/bonus/objects
			${SILENT} mkdir -p includes
			${SILENT} mkdir -p libraries
			${SILENT} touch -a ${addprefix ${SOURCES_DIR}${SUB_DIR}, ${SOURCES}}

.phony: 	fclean clean clean_bonus clean_libs clean_exe start all mandatory bonus re 

.phony: 	fclean clean clean_bonus clean_libs clean_exe start all mandatory bonus re 
