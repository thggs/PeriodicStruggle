extends ProgressBar
#Class represents a Exp progress bar
#I'd like to make this more gerenic but corrently I don't really know how 
#so.. womp womp

#start
func _ready():
	#Change the value of the bar whenever the exp changes
	#This is connected trough a signal
	PlayerData.on_exp_change.connect(change_value)
	pass
	
#Method responsible for changing the value of this progress bar 
func change_value(value : int):
	self.value = value
	
