extends AnimatedSprite

const NUM_FRAMES = 8
const TOTAL_HEALTH = 100.0

onready var shakeTimer = $ShakeTimer
onready var particleEmitters = get_tree().get_nodes_in_group("ParticleEmitters")
onready var noise = OpenSimplexNoise.new()
onready var rng = RandomNumberGenerator.new()

export var numberOfBitesToFinish = 8
var currentHealth = TOTAL_HEALTH
var healthLossPerBite = TOTAL_HEALTH / numberOfBitesToFinish

var startPosition
var acceptInput = false
var isShaking = false
var noisePos = 0
var shakeAmount = 5.0

func _ready():
	randomize()
	rng.randomize()
	noise.seed = randi()
	noise.period = 2
	noise.octaves = 2
	
	startPosition = position

func _process(delta):
	if acceptInput:
		if (currentHealth > 0):
			if (Input.is_action_just_pressed("eat")):
				currentHealth = floor(currentHealth - healthLossPerBite)
				startShaking()
				emitParticlesFromRandomEmitter()
				
	if (currentHealth <= 0):
		stopShaking()
	else:
		if (isShaking):
			processShake()
		
	frame = getCurrentAnimationFrame()
	
func _on_ShakeTimer_timeout():
	stopShaking()

func hasBeenFullyEaten():
   return currentHealth <= 0

func getCurrentAnimationFrame():
	if (hasBeenFullyEaten()):
		return NUM_FRAMES
	
	var healthRatio = currentHealth / TOTAL_HEALTH
	
	return NUM_FRAMES - (NUM_FRAMES * healthRatio)

func startShaking():
	isShaking = true
	shakeTimer.start()

func stopShaking():
	isShaking = false
	position = startPosition
	shakeTimer.stop()

func processShake():
	noisePos += 1
	position.x = position.x + (shakeAmount * noise.get_noise_2d(noise.seed, noisePos))

func emitParticlesFromRandomEmitter():
	var particleIndex = rng.randf_range(0, particleEmitters.size())
	var emitter = particleEmitters[particleIndex]
	emitter.emitting = true
