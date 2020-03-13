#!/usr/bin/env lua

local lmenu = require "lmenu"

local list = lmenu.list{
	title = "A List",
	options = {
		"foo",
		"bar",
		"baz",
	}
}

local checklist = lmenu.checklist{
	title = "A Checklist",
	options = {
		"A",
		"B",
		"C",
		"D",
	}
}

local charprompt = lmenu.charprompt{
	title = "A Charprompt",
	options = {
		{"a", "Albatross"},
		{"k", "Kestrel"},
		{"t", "Torus"},
	}
}

local prompt = lmenu.prompt{
	title = "A Prompt",
	default = "None"
}

local results = {
	list(),
	checklist(),
	charprompt(),
	prompt(),
}

