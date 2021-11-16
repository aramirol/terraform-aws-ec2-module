import boto3


class mod_test_vpc:

    def __init__(self, region, vpc_id):
        self.region = region
        self.vpc_id = vpc_id

    def isPublic(self, subnets):
        ec2 = boto3.resource(
            'ec2', region_name="{}".format(self.region))
        Public = False
        outpublic = []
        route_tables = ec2.route_tables.all()
        for route_table in route_tables:
            for ra in route_table.routes_attribute:
                if ra.get('DestinationCidrBlock') == '0.0.0.0/0' \
                 and (str(ra.get('GatewayId'))).startswith('igw-'):
                    for rs in route_table.associations_attribute:
                        outpublic.append(rs.get('SubnetId'))
        Public = set(subnets).issubset(outpublic)
        return Public

    def subnet_in_vpc(self, subnets):
        subnet_ids = []
        ec2 = boto3.resource(
            'ec2', region_name="{}".format(self.region))
        for vpc in ec2.vpcs.all():
            if vpc.id == self.vpc_id:
                for subnet in vpc.subnets.all():
                    subnet_ids.append(subnet.id)
        Invpc = set(subnets).issubset(subnet_ids)
        return Invpc
