#!/bin/sh
curator --host localhost delete indices --older-than $ES_CURATOR_DAY_OLDER_THAN --time-unit days --timestring '%Y.%m.%d'
