/*
Copyright IBM Corporation 2020

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.ServiceModel.Web;
using System.Text;

namespace Move2Kube.WindowsSample
{ 
    class WcfService
    {
        static void Main(string[] args)
        {
            string URL = "http://localhost:8080/";
            Console.WriteLine("Starting service...");
            WebServiceHost serviceHandle = new WebServiceHost(typeof(WindowsSampleService), new Uri(URL));
            Console.WriteLine("Created service host handle.");
            try
            {
                serviceHandle.AddServiceEndpoint(typeof(IWindowsSampleService), new WebHttpBinding(), "");
                Console.WriteLine("Added service endpoint [" + URL + "].");
                serviceHandle.Open();
                Console.WriteLine("Opened the service endpoint.");
                using (ChannelFactory<IWindowsSampleService> bindingHandle = new ChannelFactory<IWindowsSampleService>(new WebHttpBinding(), URL))
                {
                    Console.WriteLine("Created a binding for service.");
                    bindingHandle.Endpoint.Behaviors.Add(new WebHttpBehavior());
                    Console.WriteLine("Configured service binding to use HTTP.");
                    IWindowsSampleService channel = bindingHandle.CreateChannel();
                    Console.WriteLine("Access service using URL in browser: <" + URL + "ShowMsgGet?s=TEXT_TO_BE_SHOWN>");
                }
                Console.WriteLine("Hit <ENTER> to quit");
                Console.ReadLine();

                serviceHandle.Close();
                Console.WriteLine("Stopped service.");
            }
            catch (CommunicationException exObj)
            {
                Console.WriteLine("{0}", exObj.Message);
                serviceHandle.Abort();
            }
        }
    }
}
