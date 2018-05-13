import aiml

kernel = aiml.Kernel()
#kernel.learn("templates.aiml")
kernel.learn("test.aiml")

# Press CTRL-C to break this loop

while True:
    print(kernel.respond(raw_input("Enter your message >> ")))
