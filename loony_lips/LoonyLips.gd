extends Node2D

var player_words = [] # the words the player chooses

var template = {
	story1 = {
	"prompt":["a name", "a thing", "a feeling", "another feeling", "some things"],
	"story": "Once upon a time a %s ate a %s and felt very %s. It was a %s day for all good %s."
		},
	story2 = {
	"prompt" : ["a thing", "an adjective (a description word)", "a name", "a place", "a verb", "a second person's name", "a third person's name"],
	"story" : "A poem.\n\nI wish I was a %s, %s as can be, \n Then you could call me %s,\n And I would finally be free.\n\n Then I would visit %s \nAnd %s all day long,\nAnd I would call you %s,\nAnd teach %s my song"
		},
	story3 = {
		"prompt" : ["a person's name", "a place", "some things (plural)", "a wprd ending in -ly", "a thing"],
		"story" : "Dear %s,\n\nI hope this letter finds you well.  I have spent the past three weeks in %s researching the history of %s for my new book.  I miss you %s, and whenever I see a %s I think of you."
		}
	}
var current_story

func _ready():
	randomize()
	current_story = template.values() [randi() % template.size()]
	$Blackboard/StoryText.text = ("Welcome to Loony Lips!\n\nWe're going to tell a story and have a lovely time!\n\nCan I have " + current_story.prompt[player_words.size()] + ", please?")
	$Blackboard/TextBox.text = ""

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		var new_text = $Blackboard/TextBox.get_text()
		_on_TextBox_text_entered(new_text)

func _on_TextBox_text_entered(new_text):
	player_words.append(new_text)
	$Blackboard/TextBox.text = ""
	check_player_word_length()

func is_story_done():
	return player_words.size() == current_story.prompt.size()

func prompt_player():
	$Blackboard/StoryText.text = ("Can I have " + current_story.prompt[player_words.size()] + ", please?")

func check_player_word_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	$Blackboard/TextureButton/ButtonLabel.text = "Again!"
	end_game()

func end_game():
	$Blackboard/TextBox.queue_free()