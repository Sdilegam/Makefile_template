# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sdi-lega <sdi-lega@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/25 11:25:36 by sdi-lega          #+#    #+#              #
#    Updated: 2022/03/25 12:27:28 by sdi-lega         ###   ########.fr        #
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

#####################################
#									#
#			Sources & objects		#
#									#
#####################################

SOURCES			=	${NAME}.c#Files to compile#
OBJECTS 		=	${OBJECTS_DIR}${SOURCES:.c=.o}
LIBRARIES		=	#Libraries needed#
EXECUTABLES		=	${NAME} #Modify if other executables needed#

#####################################
#									#
#				OTHERS				#
#									#
#####################################

CC				=	gcc
CC_FLAGS		=	-Wall -Werror -Wextra
RM				=	rm -f
SLEEP_TIME		=	0.3
SILENT			=	@
SUFFIX			=	_bonus


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
${NAME}${SUFFIX}:		bonus
mandatory:				${EXECUTABLES}
bonus:					${EXECUTABLES}${SUFFIX}
re:						fclean all

#####################################
#									#
#				COMPILING			#
#									#
#####################################

${OBJECTS_DIR}%.o:	${SOURCES_DIR}${SUB_DIR}%.c
			${SILENT} ${CC} ${FLAGS} -Iincludes -c $< -o ${OBJECTS_FOLDER}${@F:.c=.o}
			${SILENT} echo  "\033[K\rCreating \"${@F:.c=.o}\".\c"
			${SILENT} sleep ${SLEEP_TIME}
			
${LIBRARIES}:		

			${SILENT} make -C $(@D)
			
${EXECUTABLES}:			${OBJECTS} ${LIBRARIES}

			${SILENT} ${CC} $^ -o $@
			${SILENT} echo "Creating the \"$@\" executable.\033[K\r\c"
			${SILENT} sleep ${SLEEP_TIME}
				
#####################################
#									#
#				CLEANING			#
#									#
#####################################

clean:

			${SILENT} echo "\033[K\rRemoving objects files (${notdir ${OBJECTS}}).\c"
			${SILENT} ${RM} ${OBJECTS}
			${SILENT} sleep ${SLEEP_TIME}

clean_bonus:

			${SILENT} make clean SUFFIX=_bonus SUBDIRECTORY=bonus/
			${SILENT} echo "\033[K\rSwitching to bonus files.\c"

clean_libs:

			${SILENT} ${RM} ${LIBRARIES}
			${SILENT} echo "\033[K\rRemoving libraries (${notdir ${LIBRARIES}}).\c"
			${SILENT} sleep ${SLEEP_TIME}

clean_exe:

			${SILENT} ${RM} ${EXECUTABLES}
			${SILENT} echo "\033[K\rRemoving executables (${notdir ${EXECUTABLES}}).\c"
			${SILENT} sleep ${SLEEP_TIME}

fclean:					clean clean_bonus clean_libs clean_exe

			${SILENT} ${RM} ${EXECUTABLES} ${LIBRARIES}
			${SILENT} echo "\033[K\rEverything removed."
			${SILENT} sleep ${SLEEP_TIME}
				
#####################################
#									#
#			INITIALIZATION			#
#									#
#####################################

start:				
			mkdir -p sources/mandatory/objects
			mkdir -p sources/bonus/objects
			mkdir -p includes
			mkdir -p libraries
			touch -a sources/mandatory/${SOURCES}

.phony: 	fclean clean clean_bonus clean_libs clean_exe start all mandatory bonus re 