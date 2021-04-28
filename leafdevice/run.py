# -------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for
# license information.
# --------------------------------------------------------------------------

# This sample has been refactored from https://github.com/Azure/azure-iot-sdk-python/blob/master/azure-iot-device/samples/async-hub-scenarios/provision_symmetric_key.py


import asyncio, os, uuid, random, time
from environment_decision import EnvironmentDecisionHelper

# Using the Python Device SDK for IoT Hub:
#   https://github.com/Azure/azure-iot-sdk-python
# The sample connects to a device-specific MQTT endpoint on your Azure IoT Hub instance.
from azure.iot.device.aio import ProvisioningDeviceClient, IoTHubDeviceClient
from azure.iot.device import Message


EnvironmentDecisionHelper.set_environment_settings()

messages_to_send = os.getenv("NUMBER_OF_MESSAGE_TO_SEND")
provisioning_host = os.getenv("PROVISIONING_HOST")
id_scope = os.getenv("PROVISIONING_IDSCOPE")
registration_id = os.getenv("PROVISIONING_REGISTRATION_ID")
symmetric_key = os.getenv("PROVISIONING_SYMMETRIC_KEY")
wait_time = os.getenv("MESSAGE_WAIT_TIME")

async def main():

    provisioning_device_client = ProvisioningDeviceClient.create_from_symmetric_key(
        provisioning_host=provisioning_host,
        registration_id=registration_id,
        id_scope=id_scope,
        symmetric_key=symmetric_key,
    )

    registration_result = await provisioning_device_client.register()

    print(f"The complete registration result is: {registration_result.registration_state}")

    if registration_result.status == "assigned":
        print("Will send telemetry from the provisioned device")
        device_client = IoTHubDeviceClient.create_from_symmetric_key(
            symmetric_key=symmetric_key,
            hostname=registration_result.registration_state.assigned_hub,
            device_id=registration_result.registration_state.device_id,
        )
        # Connect the client.
        await device_client.connect()

        async def send_test_message(i):

            temperature = 20 + (random.random() * 15)
            humidity =  60 + (random.random() * 20)
            
            # Define the JSON message to send to IoT Hub.
            msg_txt = '{{"temperature": {temperature},"humidity": {humidity}}}'
            msg_txt_formatted = msg_txt.format(temperature=temperature, humidity=humidity)
            message = Message(msg_txt_formatted)

            # Adding a custom application property to the message.
            # An IoT hub can filter on these properties without access to the message body.
            if temperature > 30:
                message.custom_properties["temperatureAlert"] = "true"
            else:
                message.custom_properties["temperatureAlert"] = "false"

            print("Sending message: {}".format(message))

            message.message_id = uuid.uuid4()
            await device_client.send_message(message)

            print(f"Completed sending message message # {i}")

            time.sleep(int(wait_time))

        # send `messages_to_send` messages concurrently
        await asyncio.gather(*[send_test_message(i) for i in range(1, int(messages_to_send) + 1)])

        # finally, disconnect
        await device_client.disconnect()
    else:
        print("Can not send telemetry from the provisioned device")


if __name__ == "__main__":
    asyncio.run(main())