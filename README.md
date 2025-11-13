# 🗂️ APEX Object Storage Uploader Plugin

**APEX Object Storage Uploader Plugin** is an **Oracle APEX Process Plugin** that allows developers to **upload files directly to Oracle Cloud Infrastructure (OCI) Object Storage** — without writing a single line of code.

With a simple drag-and-drop configuration, you can browse and upload files to any OCI Object Storage Bucket of your choice, making file management within APEX applications faster, cleaner, and fully cloud-integrated.

## Demo
![Upload Demo](./Media/Demo.gif)


## 🚀 Features

* 🔹 **No Code Required** – Upload to OCI Object Storage without writing PL/SQL or REST calls.
* 🔹 **Native APEX Experience** – Works seamlessly with Oracle APEX process flows.
* 🔹 **Customizable Bucket Targeting** – Use your choice of target Object Storage bucket.
* 🔹 **Supports All File Types** – Upload any document, image, or binary file.
* 🔹 **OCI Authentication** – Inherits the standard OCI authentication method.
* 🔹 **Developer Friendly** – Simple to integrate, easy to maintain, and fully portable.

## ⚙️ How It Works

1. **Install the Plugin**

   * Import the plugin file (`APEX_Object_Storage_Upload_Plugin.sql`) into your APEX application.
   
     ![Setup3](./Media/Setup3.png)

2. **Add to Your Process Flow**

   * In your APEX page, create a new *Process* and select **Object Storage Upload Plugin** from the list.
   
     ![Setup4](./Media/Setup4.png)

3. **Configure Settings**

   * Generate API Key Pair in your OCI tenancy and obtain the details.
     
     ![Setup1](./Media/Setup1.png)

     ![Setup2](./Media/Setup2.png)
   
   * Provide OCI connection details such as User OCID, Tenancy OCID, Private Key, Fingerprint, Region, Namespace, Bucket Name to the Plugin Parameters.
   * Link the Filename parameter to your File Upload component ( for example **&P1_FILE.** )
   
     ![Setup5](./Media/Setup5.png)

4. **Run and Upload!**

   * Browse your local files and upload them directly to the OCI bucket.
   * No manual code, REST APIs, or SDKs needed.

## 🧩 Example Use Case

Want to allow users to upload invoices, reports, or images to a secure OCI Object Storage location?
Simply drop in this plugin, configure it once, and you’re done — every file goes straight to your configured bucket.

## 🛠️ Requirements

* Oracle APEX 21.2 or higher
* OCI tenancy with access to Object Storage
* Target bucket

## 📦 Installation

1. Download the latest release from the [Plugin](./Plugin) section.
2. Import the plugin into your APEX workspace using **Shared Components → Plug-ins → Import**.
3. Create a File Upload component and a Button to submit the page.
   
   ![Setup6](./Media/Setup6.png)
   
   ![Setup7](./Media/Setup7.png)
   
4. Create a new process under execution point 'Processing', select the type as Object Storage Upload Plugin and configure the settings as shown in the previous sections.

   ![Setup8](./Media/Setup8.png)
   
6. Run the application.

## 📦 Sample Application

* Download the sample application from the [Sample Application](./Sample_Application) section.


## 🧑‍💻 Author

**Amod Joshi**

amodjjoshi@gmail.com

http://www.geek-bench.com

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](./LICENSE) file for details.

