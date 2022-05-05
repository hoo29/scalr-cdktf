import { Construct } from "constructs";
import { App, RemoteBackend, TerraformStack } from "cdktf";
import { AwsProvider, ssm } from "@cdktf/provider-aws";

class MyStack extends TerraformStack {
  constructor(scope: Construct, name: string) {
    super(scope, name);

    new AwsProvider(this, "aws", {
      region: "eu-west-1",
    });

    new ssm.SsmParameter(this, "param", {
      type: "String",
      name: "/scalr/cdktf",
      value: "it lives!",
    });
  }
}

const app = new App();
const stack = new MyStack(app, "cdk");
new RemoteBackend(stack, {} as any);
app.synth();
